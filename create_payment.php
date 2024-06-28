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
                        <a class="nav-link dropdown-toggle" href="#" id="paymentDropdown" role="button" data-toggle="dropdown" aria-expanded="false">Invoice</a>
                        <ul class="dropdown-menu" aria-labelledby="paymentDropdown">
                            <li><a class="dropdown-item" href="create_invoice.php">Create Invoice</a></li>
                            <li><a class="dropdown-item" href="templates/invoice.php">View Invoice</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="paymentDropdown" role="button" data-toggle="dropdown" aria-expanded="false">Payment</a>
                        <ul class="dropdown-menu" aria-labelledby="paymentDropdown">
                            <li><a class="dropdown-item" href="create_payment.php">Create Payment</a></li>
                            <li><a class="dropdown-item" href="templates/payment.php">View Payments</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view_reports.php">View Reports</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>
<div class="container " style="padding-top: 80px; width:700px">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <h2>Create Payment</h2>
            <form action="create_payment.php" method="POST">
                <div class="mb-3">
                    <label for="payment_date" class="form-label">Payment Date</label>
                    <input type="date" class="form-control" id="payment_date" name="payment_date" required>
                </div>
                <div class="mb-3">
                    <label for="amount" class="form-label">Amount</label>
                    <input type="number" step="0.01" class="form-control" id="amount" name="amount" required>
                </div>
                <div class="mb-3">
                    <label for="transaction_details" class="form-label">Transaction Details</label>
                    <input type="text" class="form-control" id="transaction_details" name="transaction_details" required>
                </div>
                <div class="mb-3">
                    <label for="bill_id" class="form-label">Bill ID</label>
                    <select class="form-select" id="bill_id" name="bill_id" required>
                        <option value="">Select Bill ID</option>
                        <?php while ($row = $result_bills->fetch_assoc()) : ?>
                            <option value="<?php echo $row['bill_id']; ?>"><?php echo $row['bill_id']; ?></option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="order_id" class="form-label">Order ID</label>
                    <select class="form-select" id="order_id" name="order_id" required>
                        <option value="">Select Order ID</option>
                        <?php while ($row = $result_orders->fetch_assoc()) : ?>
                            <option value="<?php echo $row['order_id']; ?>"><?php echo $row['order_id']; ?></option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="release_order_id" class="form-label">Release Order ID</label>
                    <select class="form-select" id="release_order_id" name="release_order_id" required>
                        <option value="">Select Release Order ID</option>
                        <?php while ($row = $result_release_orders->fetch_assoc()) : ?>
                            <option value="<?php echo $row['release_order_id']; ?>"><?php echo $row['release_order_id']; ?></option>
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
                <button type="submit" class="btn btn-primary">Create Payment</button>
            </form>
        </div>
    </div>
</div>

<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $payment_date = $_POST['payment_date'];
    $amount = $_POST['amount'];
    $transaction_details = $_POST['transaction_details'];
    $bill_id = $_POST['bill_id'];
    $order_id = $_POST['order_id'];
    $release_order_id = $_POST['release_order_id'];
    $staff_id = $_POST['staff_id'];

    $conn->begin_transaction();

    try {
        $insert_payment_sql = "INSERT INTO payment (payment_date, amount, transaction_details, bill_id, order_id, release_order_id, staff_id) 
                               VALUES ('$payment_date', $amount, '$transaction_details', $bill_id, $order_id, $release_order_id, $staff_id)";
        $conn->query($insert_payment_sql);

        $update_billing_sql = "UPDATE billing SET total_amount = total_amount - $amount WHERE bill_id = $bill_id";
        $conn->query($update_billing_sql);

        $check_amount_due_sql = "SELECT total_amount FROM billing WHERE bill_id = $bill_id";
        $result = $conn->query($check_amount_due_sql);
        $row = $result->fetch_assoc();

        if ($row['total_amount'] == 0) {
            $update_status_sql = "UPDATE billing 
                                  SET status = 'Paid' 
                                  WHERE bill_id = $bill_id";
            $conn->query($update_status_sql);
        }

        $conn->commit();
        echo "<div class='alert alert-success' role='alert'>Payment recorded successfully and billing table updated.</div>";
    } catch (Exception $e) {
        $conn->rollback();
        echo "Error: " . $e->getMessage();
    }
}
?>
<?php include('includes/footer.php'); ?>