<?php
include '../php/db_script.php';
session_start();
if (!isset($_SESSION['party_name'])) {
    header('Location: ../pages/unauth.html');
    session_destroy();
}
$conn = get_connection();
$cities = get_data_from_db($conn, $_SESSION["party_name"],
    "SELECT city_name    
         FROM user_data.city_owners 
         WHERE party_name=:party_name");
$events = get_data_from_db($conn, $_SESSION["party_name"],
    "SELECT event_name, city_name, time, theme    
         FROM user_data.events 
         WHERE party_name=:party_name");
$event_attendees = get_data_from_db($conn, $_SESSION["party_name"], "SELECT member_name, event_name
                                                                        FROM user_data.event_attendees 
                                                                        WHERE party_name=:party_name");
$members = get_data_from_db($conn, $_SESSION["party_name"], "SELECT name, birth_date, payout, position, work_time, image
                                                        FROM user_data.party_members 
                                                        WHERE party_name=:party_name");
$_SESSION["members"] = $members;
$_SESSION["event_attendees"] = $event_attendees;
$_SESSION["events"] = $events;
$participants = [];
?>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Панель управления</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-LtrjvnR4Twt/qOuYxE721u19sVFLVSA4hf/rRt6PrZTmiPltdZcI7q7PXQBYTKyf" crossorigin="anonymous"></script>
    </head>
    <body>
    <!--Партийная работа: список членов партии, список мероприятий, журнал учета выхода на мероприятие, список городов-->
    <div class="container mt-3">
        <div style="display: flex; flex-direction: row;">
            <h2 style="flex-grow: 3">Редактирование посещения мероприятий</h2>
            <h2 style="flex-grow: 2"><?php echo $_SESSION['party_name']?></h2>
            <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="index.php">На главную</a>
            <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="../php/logout_script.php">Выход</a>
        </div>
        <br>
        <ul class="nav nav-pills nav-justified" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="pill" href="#attendance">Посещение мероприятий</a>
            </li>
        </ul><br>

        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane container active" id="attendance" >
                <!--                    <button type="button" class="btn btn-primary" style="max-width: max-content;">Добавить</button>-->
                <div id="formContent">
                    <?php
                    if (isset($_SESSION["invalid_input"]) && ($_SESSION["invalid_input"])) {
                        echo "<p>Некорректные данные. Попробуйте еще раз</p>";
                        $_SESSION["invalid_input"] = false;
                    }
                    if (isset($_SESSION["event_exists"]) && ($_SESSION["event_exists"])) {
                        echo "<p>Эти люди уже были назначены на это событие</p>";
                        $_SESSION["event_exists"] = false;
                    }
                    ?>
                </div>
                <br/><br/><br/><hr>
                <?php
                if ($events != "not found") {
                    for ($counter = 0; $counter < count($events); $counter++) {
                        echo "<p>" . $events[$counter]["event_name"] . "</p>
                        <ul>";
                        if ($event_attendees != "not found") {
                            for ($counter2 = 0; $counter2 < count($event_attendees); $counter2++) {
                                if ($event_attendees[$counter2]["event_name"] == $events[$counter]["event_name"]) {
                                    echo "<li>" . $event_attendees[$counter2]["member_name"] . "</li>";
                                    $participants[$counter2] = $event_attendees[$counter2]["member_name"];
                                }
                            }
                        }
                        echo "</ul>";

                        echo "<form action='../php/edit_attendance_script.php' method='post'>
                        <br>
                        <input hidden required readonly='readonly' type='text' id='event_name' name='event_name' value='" . $events[$counter]["event_name"] . "'>
                        <input hidden required readonly='readonly' type='text' id='add' name='add' value='add'>
                        <input type='submit' class='btn btn-primary' style='max-width: max-content;' value='Добавить:'
                        <br>";
                        for ($counter2 = 0; $counter2 < count($members); $counter2++) {
                            if (!in_array($members[$counter2]["name"], $participants)) {
                                echo "<input type='checkbox' id='newAttendee". $counter2 ."' name='newAttendee[]' value='". $members[$counter2]["name"] ."'>
                                <label for='newAttendee". $counter2 ."'> ". $members[$counter2]["name"] ."</label>";
                            }
                        }
                        echo " </form>";
                        if ((!empty($participants)) && ($event_attendees != "not found")) {
                            echo "<form action='../php/edit_attendance_script.php' method='post'>
                            <br>
                            <input hidden required readonly='readonly' type='text' id='event_name' name='event_name' value='" . $events[$counter]["event_name"] . "'>
                            <input hidden required readonly='readonly' type='text' id='delete' name='delete' value='delete'>
                            <input type='submit' class='btn btn-primary' style='max-width: max-content;' value='Удалить:'
                            <br>";
                            for ($counter2 = 0; $counter2 < count($members); $counter2++) {
                                if (in_array($members[$counter2]["name"], $participants)) {
                                    echo "<input type='checkbox' id='oldAttendee" . $counter2 . "' name='oldAttendee[]' value='" . $members[$counter2]["name"] . "'>
                                    <label for='oldAttendee" . $counter2 . "'> " . $members[$counter2]["name"] . "</label>";
                                }
                            }
                            echo "</form>";
                        }
                        else {
                            echo "<form action='../php/edit_attendance_script.php' method='post'>
                            <br>
                            <input hidden required readonly='readonly' type='text' id='event_name' name='event_name' value='" . $events[$counter]["event_name"] . "'>
                            <input hidden required readonly='readonly' type='text' id='delete' name='delete' value='delete'>
                            <input type='submit' class='btn btn-primary' style='max-width: max-content;' value='Удалить:'
                            <br>";
//                            for ($counter2 = 0; $counter2 < count($members); $counter2++) {
//                                    echo "<input type='checkbox' id='oldAttendee" . $counter2 . "' name='oldAttendee[]' value='" . $members[$counter2]["name"] . "'>
//                                    <label for='oldAttendee" . $counter2 . "'> " . $members[$counter2]["name"] . "</label>";
//                            }
//                            echo "</form>";
                        }
                        echo "<br><hr>
                        ";
                        $participants = [];
                    }
                }

                else
                    echo "<p>No data for attendance of this party's events!</p>";
                ?>
            </div>
        </div>
    </div>
    <script src="../js/event_from_validation.js"></script>
    </body>
    </html>
<?php
if ((isset($_SERVER['REMOTE_ADDR'])) && (isset($_SERVER['REQUEST_TIME'])) && (isset($_SERVER['HTTP_REFERER'])) && (isset($_SERVER['HTTP_USER_AGENT'])))
    log_statistics($_SERVER['REMOTE_ADDR'], $_SERVER['REQUEST_TIME'], $_SERVER['HTTP_REFERER'], 'edit_attendance',
        'edit_attendance_visits', $_SERVER['HTTP_USER_AGENT']);
?>