<?php
// Include the database configuration file
include_once 'db_script.php';

function delete_avatar($member_name) {
    $party_name = $_SESSION["party_name"];
    $targetDir = "../uploads/";
    $conn = get_connection();
    $fileNameArr = get_data_from_db($conn, $party_name,
        "SELECT image
            FROM user_data.party_members 
            WHERE party_name=:party_name AND
            name = '$member_name';");
    $fileName = $fileNameArr[0]['image'];
    if($fileName == null)
        return -1;
    $targetFilePath = $targetDir . $fileName;
    unlink($targetFilePath) or die("Couldn't delete file");
    $insert_prepared = $conn->prepare("UPDATE user_data.party_members
                                                            SET
                                                                image = ''
                                                            WHERE
                                                                party_name = '$party_name' AND
                                                                name = '$member_name';");
    $insert_prepared->execute();
    return 1;
}

function upload_avatar($party_name, $member_name)
{
    $statusMsg = '';

    // File upload path
    $targetDir = "../uploads/";
    $fileName = basename($_FILES["fileToUpload"]["name"]);
    $targetFilePath = $targetDir . $fileName;
    $fileType = pathinfo($targetFilePath, PATHINFO_EXTENSION);

    if (!empty($_FILES["fileToUpload"]["name"])) {
        // Allow certain file formats
        $allowTypes = array('jpg', 'png', 'jpeg', 'gif', 'pdf');
        if (in_array($fileType, $allowTypes)) {
            // Upload file to server
            if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $targetFilePath)) {
                // Insert image file name into database
                $conn = get_connection();
                $insert_prepared = $conn->prepare("UPDATE user_data.party_members
                                                            SET
                                                                image = '$fileName'
                                                            WHERE
                                                                party_name = '$party_name' AND
                                                                name = '$member_name';");
                $insert = $insert_prepared->execute();
                if ($insert) {
                    $statusMsg = "The file " . $fileName . " has been uploaded successfully.";
                } else {
                    $statusMsg = "File upload failed, please try again.";
                }
            } else {
                $statusMsg = "Sorry, there was an error uploading your file.";
            }
        } else {
            $statusMsg = 'Sorry, only JPG, JPEG, PNG, GIF, & PDF files are allowed to upload.';
        }
    } else {
        $statusMsg = 'Please select a file to upload.';
    }
    $conn = null;
    // Display status message
    echo $statusMsg;
}
