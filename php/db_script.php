<?php
function get_connection() {
    $servername = "localhost";
    $username = "root";
    $sql = '';
    try {
        $conn = new PDO("mysql:host=$servername", $username);
        // set the PDO error mode to exception
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch(PDOException $e) {
        echo $sql . "<br>" . $e->getMessage();
        $conn = null;
    }
    return $conn;
}

function get_data_from_db($connection, $pname, $sql) {
    $search_for_data = $connection->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $search_for_data->execute(array(':party_name'=>$pname));
    $found_data = $search_for_data->fetchAll();
    if (!empty($found_data)) {
        return $found_data;
    }
    else
        return "not found";
}

function pull_data_for_session($conn, $party_name) {
    session_start();
    $members = get_data_from_db($conn, $party_name, "SELECT name, birth_date, payout, position, work_time, image
                                                        FROM user_data.party_members 
                                                        WHERE party_name=:party_name");
    $cities = get_data_from_db($conn, $party_name, "SELECT city_name
                                                      FROM user_data.city_owners 
                                                      WHERE party_name=:party_name");
    $events = get_data_from_db($conn, $party_name, "SELECT event_name, city_name, theme, time
                                                      FROM user_data.events 
                                                      WHERE party_name=:party_name");
    $event_attendees = get_data_from_db($conn, $party_name, "SELECT member_name, event_name
                                                                        FROM user_data.event_attendees 
                                                                        WHERE party_name=:party_name");
    $_SESSION['party_name'] = $party_name;
    $_SESSION['members'] = $members;
    $_SESSION['cities'] = $cities;
    $_SESSION['events'] = $events;
    $_SESSION['event_attendees'] = $event_attendees;
}

function increment_field($table, $field) {
    $conn = get_connection();
    $sql = 'UPDATE user_data.' . $table . ' SET ' . $field . ' = ' . $field . ' + 1 WHERE id = 1';
    $increment = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $increment->execute();
    $conn = null;
}

function insert_ip_addr($ip) {
    $conn = get_connection();
    $sql = "INSERT IGNORE INTO user_data.unique_visits SET ip_addr = '$ip'";
    $insert = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $insert->execute();
    $conn = null;
}

function insert_redirect($source, $ip, $time, $target) {
    $timestamp = date('Y-m-d H:i:s', $time);
    $conn = get_connection();
    $sql = 'INSERT INTO user_data.redirects(redirect_source, request_time, ip_addr, redirect_target) 
                   VALUES (:source, :request_time, :ip_addr, :target)';
    $insert = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $insert->execute(array(':source'=>$source, ':request_time'=>$timestamp, ':ip_addr'=>$ip, ':target'=>$target));
    $conn = null;
}

function get_visits() {
    $conn = get_connection();
    $sql = 'SELECT index_visits, login_visits, signup_visits
            FROM user_data.visit_count 
            WHERE id = 1';
    $search_for_data = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $search_for_data->execute();
    $found_data = $search_for_data->fetchAll();
    return $found_data;
}

function count_registered_users() {
    $conn = get_connection();
    $sql = 'SELECT COUNT(*) FROM user_data.credentials';
    $count_expr = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $count_expr->execute();
    $count = $count_expr->fetch();
    return $count;
}

function count_unique_visits() {
    $conn = get_connection();
    $sql = 'SELECT COUNT(*) FROM user_data.unique_visits';
    $count_expr = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $count_expr->execute();
    $count = $count_expr->fetch();
    return $count;
}

function get_redirects() {
    $conn = get_connection();
    $sql = 'SELECT redirect_source, request_time, ip_addr, redirect_target 
            FROM user_data.redirects';
    $search_for_data = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $search_for_data->execute();
    $found_data = $search_for_data->fetchAll();
    return $found_data;
}

function log_statistics($ip, $time, $source, $target, $visit_counter_type, $user_agent) {
    if (!((isset($user_agent)) && preg_match('/bot|crawl|slurp|spider|mediapartners/i', $user_agent))) {
        increment_field('visit_count', $visit_counter_type);
        insert_ip_addr($ip);
        insert_redirect($source, $ip, $time, $target);
    }
}