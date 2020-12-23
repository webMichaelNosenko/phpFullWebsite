<?php
include 'db_script.php';
session_start();
$event_name = $_POST["event_name"];

if (isset($_POST["old_event_name"]))
    $old_event_name = $_POST["old_event_name"];

if ((isset($_POST['delete'])) && ($_POST['delete'] == 'delete')) {
    $conn = get_connection();
    $sql = "DELETE FROM user_data.events WHERE event_name = '$event_name'";
    $delete_event = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $delete_event->execute();
    header("Location: ../pages/edit_events.php");
    die();
}
$date_time = $_POST["date_time"];
$city_name = $_POST["city_name"];
$theme = $_POST["theme"];

$conn = get_connection();
$cities = get_data_from_db($conn, $_SESSION["party_name"],
    "SELECT city_name    
         FROM user_data.city_owners 
         WHERE party_name=:party_name");

if ((strlen($event_name) > 100) || ($date_time == NULL) || ($theme == NULL)) {
    $_SESSION["invalid_input"] = true;
    header("Location: ../pages/edit_events.php");
}

if (isset($_SESSION["cities"])) {
    $_SESSION["invalid_input"] = true;
    for ($counter = 0; $counter < count($cities); $counter++) {
        if (in_array($city_name, $cities[$counter])) {
            $_SESSION["invalid_input"] = false;
        }
    }
    if ($_SESSION["invalid_input"]) {
        header("Location: ../pages/edit_events.php");
    }
}

if (isset($_SESSION["events"])) {
    for ($counter = 0; $counter < count($_SESSION['events']); $counter++) {
        if (($event_name === $_SESSION["events"][$counter]["event_name"])) {
            $_SESSION["event_exists"] = true;
            header("Location: ../pages/edit_events.php");
            die();
        }
    }
}

$date_time = date('Y-m-d H:i:s', strtotime($date_time));

if ($_POST['redact'] == 'redact') {
    $sql = "UPDATE user_data.events 
            SET city_name = '$city_name',
                theme = '$theme',
                time = '$date_time'
            WHERE event_name = '$old_event_name'";
    $update_event = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $update_event->execute();
    header("Location: ../pages/edit_events.php");
    $conn = null;
    die();
}

$sql = "INSERT INTO user_data.events(city_name, event_name, party_name, theme, time) 
        VALUES ('$city_name', '$event_name', '" . $_SESSION["party_name"] . "', '$theme', '$date_time')";
$insert = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
$insert->execute();

$_SESSION["events"] = get_data_from_db($conn, $_SESSION["party_name"],
    "SELECT city_name, event_name, theme, time
         FROM user_data.events 
         WHERE party_name=:party_name");
$conn = null;
header("Location: ../pages/edit_events.php");
