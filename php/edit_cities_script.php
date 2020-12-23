<?php
include 'db_script.php';
include 'upload_script.php';
session_start();
if((isset($_POST['delete'])) && ($_POST['delete'] == 'delete')) {
    $conn = get_connection();
    $party_name = $_SESSION['party_name'];
    $old_city_name = $_POST['old_city_name'];
    $sql = "DELETE FROM user_data.city_owners WHERE party_name = '$party_name' AND
                                              city_name = '$old_city_name'";
    $delete_city = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $delete_city->execute();
    $_SESSION["cities"] = get_data_from_db($conn, $_SESSION["party_name"],
        "SELECT city_name
         FROM user_data.city_owners 
         WHERE party_name=:party_name");
    $_SESSION["events"] = get_data_from_db($conn, $_SESSION["party_name"],
        "SELECT event_name, city_name, time, theme    
         FROM user_data.events 
         WHERE party_name=:party_name");
    header("Location: ../pages/edit_cities.php");
    die();
}
else {
    $party_name = $_SESSION['party_name'];
    $city_name = $_POST['city_name'];
    if ((strlen($city_name) > 40) || ($city_name == NULL)) {
        $_SESSION["invalid_input"] = true;
        header("Location: ../pages/edit_cities.php");
        die();
    }
    if (isset($_SESSION["cities"])) {
        for ($counter = 0; $counter < count($_SESSION['cities']); $counter++) {
            if (($city_name === $_SESSION["cities"][$counter]["city_name"])) {
                $_SESSION["city_exists"] = true;
                header("Location: ../pages/edit_cities.php");
                die();
            }
        }
    }
    $conn = get_connection();
    $sql = "INSERT INTO user_data.city_owners(city_name, party_name) 
        VALUES ('$city_name',  '" . $_SESSION["party_name"] . "')";
    $insert = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $insert->execute();

    $_SESSION["cities"] = get_data_from_db($conn, $_SESSION["party_name"],
        "SELECT city_name
         FROM user_data.city_owners 
         WHERE party_name=:party_name");
    $conn = null;
    header("Location: ../pages/edit_cities.php");
}