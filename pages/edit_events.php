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
$_SESSION["events"] = $events;
$event_attendees = get_data_from_db($conn, $_SESSION["party_name"], "SELECT member_name, event_name
                                                                        FROM user_data.event_attendees 
                                                                        WHERE party_name=:party_name");
$_SESSION["event_attendees"] = $event_attendees;
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
        <!--        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">-->
        <!--        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>-->
        <!--        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->
        <!--        <link rel="stylesheet" href="../css/login_style.css">-->
    </head>
    <body>
    <!--Партийная работа: список членов партии, список мероприятий, журнал учета выхода на мероприятие, список городов-->
    <div class="container mt-3">
        <div style="display: flex; flex-direction: row;">
            <h2 style="flex-grow: 3">Редактирование мероприятий</h2>
            <h2 style="flex-grow: 2"><?php echo $_SESSION['party_name']?></h2>
            <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="index.php">На главную</a>
            <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="../php/logout_script.php">Выход</a>
        </div>
        <br>
        <ul class="nav nav-pills nav-justified" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="pill" href="#events">Мероприятия</a>
            </li>
        </ul><br>

        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane container active" id="events" >
                <!--                    <button type="button" class="btn btn-primary" style="max-width: max-content;">Добавить</button>-->
                <div id="formContent">
                    <?php
                    if (isset($_SESSION["invalid_input"]) && ($_SESSION["invalid_input"])) {
                        echo "<p>Некорректные данные. Попробуйте еще раз</p>";
                        $_SESSION["invalid_input"] = false;
                    }
                    if (isset($_SESSION["event_exists"]) && ($_SESSION["event_exists"])) {
                        echo "<p>Такое событие уже существует</p>";
                        $_SESSION["event_exists"] = false;
                    }
                    ?>
                    <form action="../php/edit_events_script.php" method="post">
                        <input required maxlength="100" type="text" id="event_name" class="fadeIn second" name="event_name" placeholder="Название события">

                        <input required type="datetime-local" id="date_time" class="fadeIn third" name="date_time" placeholder="Время гггг-мм-дд ч:м:с">

                        <select required type="text" id="city_name" name="city_name">
                        <?php
                        if ($cities != "not found") {
                            for ($counter = 0; $counter < count($cities); $counter++) {
                            echo "
                                <option value='" . $cities[$counter]["city_name"] . "'>"
                                . $cities[$counter]["city_name"] . "</option>
                            ";
                            }
                        }
                        ?>
                        </select>
                        <input required type="text" id="theme" name="theme" placeholder="Тема">

                        <span class="error" id="eventNameError" aria-live="polite"></span>
                        <span class="error" id="dateTimeError" aria-live="polite"></span>
                        <span class="error" id="cityNameError" aria-live="polite"></span>
                        <span class="error" id="themeError" aria-live="polite"></span>
                        <br><br>
                        <input type="submit" class="btn btn-primary" style="max-width: max-content;" value="Добавить">
                    </form>
                </div>
                <br/><br/><br/><hr>
                <?php
                if ($events != "not found") {
                    for ($counter = 0; $counter < count($events); $counter++) {
                        echo "
                            <p id='" . $events[$counter]["event_name"] . "'>" . $events[$counter]["event_name"] . "</p>
                            <form action='../php/edit_events_script.php' method='post'>
                                <input hidden required readonly='readonly' type='text' id='event_name' name='event_name' value='" . $events[$counter]["event_name"] . "'>
                                <input hidden required readonly='readonly' type='text' id='delete' name='delete' value='delete'>
                                <input type='submit' type='button' class='btn btn-primary' style='max-width: max-content; flex-grow: 1; margin-right: 15px' value='Удалить'>
                            </form>
                            <br>
                            <ul>
                                <li>Название мероприятия - " . $events[$counter]["event_name"] . "</li>
                                <li>Дата и время - " . $events[$counter]["time"] . "</li>
                                <li>Тема - " . $events[$counter]["theme"] . "</li>
                                <li>Город - " . $events[$counter]["city_name"] . "</li>
                            </ul>
                            <div id='formContent'>
                            <form action='../php/edit_events_script.php' method='post'>
        
                                <input required type='datetime-local' id='date_time' class='fadeIn third' name='date_time' placeholder='Время гггг-мм-дд ч:м:с'>
        
                                <select required type='text' id='city_name' name='city_name'> ";
                        if ($cities != "not found") {
                            for ($counter2 = 0; $counter2 < count($cities); $counter2++) {
                                echo "
                                <option value='" . $cities[$counter2]["city_name"] . "'>"
                                        . $cities[$counter2]['city_name'] . "</option>
                                ";
                            }
                        }
                        echo "
                            </select>
                            <input required type='text' id='theme' name='theme' placeholder='Тема'>
                            <input hidden required readonly='readonly' type='text' id='old_event_name' name='old_event_name' value='" . $events[$counter]["event_name"] . "'>
                            <input hidden required readonly='readonly' type='text' id='redact' name='redact' value='redact'>
                            <span class='error' id='dateTimeError' aria-live='polite'></span>
                            <span class='error' id='cityNameError' aria-live='polite'></span>
                            <span class='error' id='themeError' aria-live='polite'></span>
                            <br><br>
                            <input type='submit' class='btn btn-primary' style='max-width: max-content;' value='Редактировать'>
                        </form>
                        <br><hr>
                                     ";
                    }
                }
                else
                    echo "<p>No data for events of this party!</p>";
                ?>
            </div>
        </div>
    </div>
    <script src="../js/event_from_validation.js"></script>
    </body>
    </html>
<?php
if ((isset($_SERVER['REMOTE_ADDR'])) && (isset($_SERVER['REQUEST_TIME'])) && (isset($_SERVER['HTTP_REFERER'])) && (isset($_SERVER['HTTP_USER_AGENT'])))
    log_statistics($_SERVER['REMOTE_ADDR'], $_SERVER['REQUEST_TIME'], $_SERVER['HTTP_REFERER'], 'edit_events',
        'edit_events_visits', $_SERVER['HTTP_USER_AGENT']);
?>