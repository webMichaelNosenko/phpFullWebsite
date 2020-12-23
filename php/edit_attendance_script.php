<?php
include 'db_script.php';
session_start();
$event_name = $_POST["event_name"];
if (isset($_POST["add"])) {
    $new_attendees = $_POST["newAttendee"];
    $conn = get_connection();
    for ($counter = 0; $counter < count($new_attendees); $counter++) {
        $sql = "INSERT INTO user_data.event_attendees(event_name, party_name, member_name) 
        VALUES ('$event_name', '" . $_SESSION["party_name"] . "', '$new_attendees[$counter]')";
        $insert = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
        $insert->execute();
    }
    $conn = null;
    header("Location: ../pages/edit_attendance.php");
}
else if (isset($_POST["delete"])) {
    $old_attendees = $_POST["oldAttendee"];
    $conn = get_connection();
    $party_name = $_SESSION["party_name"];
    for ($counter = 0; $counter < count($old_attendees); $counter++) {
        $sql = "DELETE FROM user_data.event_attendees WHERE member_name = '$old_attendees[$counter]' AND party_name = '$party_name'";
        $delete = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
        $delete->execute();
    }
    $conn = null;
    header("Location: ../pages/edit_attendance.php");
}