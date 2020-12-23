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
$conn = null;
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
            <h2 style="flex-grow: 3">Поиск</h2>
            <h2 style="flex-grow: 2"><?php echo $_SESSION['party_name']?></h2>
            <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="index.php">На главную</a>
            <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="../php/logout_script.php">Выход</a>
        </div>
        <br>
        <ul class="nav nav-pills nav-justified" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="pill" href="#cities">Поиск</a>
            </li>
        </ul><br>

        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane container active" id="cities" >
                <form>
                    <input id="searchField" required type="text">
                    <input type="submit" id="search" class="btn btn-primary" style="max-width: max-content;" value="Найти">
                </form>


                <br/><br/><br/><hr>
                <?php
                if ($cities != "not found") {
                    for ($counter = 0; $counter < count($cities); $counter++) {
                        echo "
                            <a class='item' hidden id='" . $cities[$counter]["city_name"] . "' 
                            href='edit_cities.php#" . $cities[$counter]["city_name"] . "'>" . $cities[$counter]["city_name"] . "</a>";
                    }
                }
                if ($events != "not found") {
                    for ($counter = 0; $counter < count($events); $counter++) {
                        echo "
                            <a  class='item' hidden id='" . $events[$counter]["event_name"] . "' 
                            href='edit_events.php#" . $events[$counter]["event_name"] . "'>" . $events[$counter]["event_name"] . "</a>";
                    }
                }
                if ($members != "not found") {
                    for ($counter = 0; $counter < count($members); $counter++) {
                        echo "
                            <a  class='item' hidden id='" . $members[$counter]["name"] . "' 
                            href='edit_members.php#" . $members[$counter]["name"] . "'>" . $members[$counter]["name"] . "</a>";
                    }
                }
                ?>
            </div>
        </div>
    </div>
    <script src="../js/search.js"></script>
    </body>
    </html>
<?php
if ((isset($_SERVER['REMOTE_ADDR'])) && (isset($_SERVER['REQUEST_TIME'])) && (isset($_SERVER['HTTP_REFERER'])) && (isset($_SERVER['HTTP_USER_AGENT'])))
    log_statistics($_SERVER['REMOTE_ADDR'], $_SERVER['REQUEST_TIME'], $_SERVER['HTTP_REFERER'], 'edit_cities',
        'edit_cities_visits', $_SERVER['HTTP_USER_AGENT']);
?>