<?php
include 'db_script.php';
$party_name = $_POST['party_name'];
$password = $_POST['password'];


try {
    log_statistics($_SERVER['REMOTE_ADDR'], $_SERVER['REQUEST_TIME'], $_SERVER['HTTP_REFERER'], 'signup',
        'signup_visits', $_SERVER['HTTP_USER_AGENT']);
    //insert_redirect($source, $ip, $time, 'login');

    $conn = get_connection();
    $sql = "SELECT password FROM user_data.credentials WHERE party_name=:party_name";
    $search_for_pass = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $search_for_pass->execute(array(':party_name'=>$party_name));
    $found_password = $search_for_pass->fetchAll();
    $stored_pass_hash = $found_password[0]['password'];
    if ((!empty($found_password)) && (password_verify($password, $stored_pass_hash))) {
        if (isset($_POST['remember'])) {
            setcookie("party_name", 'party_' . md5($party_name) . '_cookie', time() + 3600, "/");
        }
        pull_data_for_session($conn, $party_name);
        header('Location: ../pages/index.php');
    }
    else {
            session_start();
            $_SESSION["failed_login"] += 1;
            header('Location: ../pages/login.php');
        }
    } catch(PDOException $e) {
    echo $sql . "<br>" . $e->getMessage();
}

$conn = null;