<?php include('includes/header.php'); ?>
<?php include('includes/db.php'); ?>
<?php
// Fetch data for dropdown options
$sql_bills = "SELECT bill_id FROM billing";
$result_bills = $conn->query($sql_bills);

$sql_orders = "SELECT order_id FROM seize_order";
$result_orders = $conn->query($sql_orders);

$sql_release_orders = "SELECT release_order_id FROM release_order";
$result_release_orders = $conn->query($sql_release_orders);

$sql_staff = "SELECT staff_id, name FROM staff";
$result_staff = $conn->query($sql_staff);

$sql_custody_charge="select charge_id from custody_charge";
$result_custody=$conn->query($sql_custody_charge);
?>
<div class="container">
    <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.php">FMS</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav me-auto mb-2 mb-md-0">
                    <li class="nav-item">
                        <a class="nav-link " aria-current="page" href="index.php">Home</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="paymentDropdown" role="button" data-toggle="dropdown" aria-expanded="false">Invoice</a>
                        <ul class="dropdown-menu" aria-labelledby="paymentDropdown">
                            <li><a class="dropdown-item" href="create_invoice.php">Create Invoice</a></li>
                            <li><a class="dropdown-item" href="templates/invoice.php">View Invoice</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="paymentDropdown" role="button" data-toggle="dropdown" aria-expanded="false">Payment</a>
                        <ul class="dropdown-menu" aria-labelledby="paymentDropdown">
                            <li><a class="dropdown-item" href="create_payment.php">Create Payment</a></li>
                            <li><a class="dropdown-item" href="templates/payment.php">View Payments</a></li>
                        </ul>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="view_reports.php">View Reports</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>
<div class="container" style="padding-top: 80px; width:700px">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <h2>Create Invoice</h2>
            <form action="create_invoice.php" method="POST">
                <div class="mb-3">
                    <label for="date" class="form-label">Date</label>
                    <input type="date" class="form-control" id="date" name="date" required>
                </div>
                <div class="mb-3">
                    <label for="order_id" class="form-label">Seize Order ID</label>
                    <select class="form-select" id="order_id" name="seize_order_id" required>
                        <option value="">Select Order ID</option>
                        <?php while ($row = $result_orders->fetch_assoc()) : ?>
                            <option value="<?php echo $row['order_id']; ?>"><?php echo $row['order_id']; ?></option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="staff_id" class="form-label">Staff ID</label>
                    <select class="form-select" id="staff_id" name="staff_id" required>
                        <option value="">Select Staff ID</option>
                        <?php while ($row = $result_staff->fetch_assoc()) : ?>
                            <option value="<?php echo $row['staff_id']; ?>"><?php echo $row['name']; ?></option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="custody_charge_id" class="form-label">Custody Charge ID</label>
                    <select class="form-select" id="charge_id" name="custody_charge_id" required>
                        <option value="">Select charge ID</option>
                        <?php while ($row = $result_custody->fetch_assoc()) : ?>
                            <option value="<?php echo $row['charge_id']; ?>"><?php echo $row['charge_id']; ?></option>
                        <?php endwhile; ?>
                    </select>                </div>
                <button type="submit" class="btn btn-primary">Create Invoice</button>
            </form>
        </div>
    </div>
</div>
<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $date = $_POST['date'];
    $seize_order_id = $_POST['seize_order_id'];
    $staff_id = $_POST['staff_id'];
    $custody_charge_id = $_POST['custody_charge_id'];

    // Calculate total days and charge per day from custody_charge table
    $charge_query = "SELECT effect_date,till_date,daily_charge FROM custody_charge WHERE charge_id = $custody_charge_id";
    $charge_result = $conn->query($charge_query);
    $charge_row = $charge_result->fetch_assoc();
    $charge_per_day = $charge_row['daily_charge'];
    $effect_date=$charge_row['effect_date'];
    $till_date=$charge_row['till_date'];
    $effect_date_obj = new DateTime($effect_date);
    $till_date_obj = new DateTime($till_date);
    
    // Calculate the difference
    $date_diff = $effect_date_obj->diff($till_date_obj);
    $total_days = $date_diff->days; 
    $total_amount = $total_days * $charge_per_day;

    $sql = "INSERT INTO billing (date, total_days, charge_per_day, total_amount, bill_date, due_date, status, seize_order_id, staff_id, custody_charge_id) 
            VALUES ('$date', $total_days, $charge_per_day, $total_amount, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 'Not Paid', $seize_order_id, $staff_id, $custody_charge_id)";

    if ($conn->query($sql) === TRUE) {
        echo "<div class='alert alert-success' role='alert'>New invoice created successfully</div>";
    } else {
        echo "<div class='alert alert-danger' role='alert'>Error: " . $sql . "<br>" . $conn->error . "</div>";
    }

    $conn->close();
}
?>

<?php include('includes/footer.php'); ?>