<?php include('../includes/header.php'); ?>
<?php include('../includes/db.php'); ?>

<div class="row">
    <div class="col-md-12">
        <button class="btn btn-secondary float-right" style="margin-top: 30px;" onclick="history.back()">Back</button>
        <h2 style="padding-top: 30px;">Payments</h2>

        <table class="table table-bordered" style="margin-top: 80px; border:2px">
            <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>Payment Date</th>
                    <th>Amount</th>
                    <th>Transaction Details</th>
                    <th>Bill ID</th>
                    <th>Order ID</th>
                    <th>Release Order ID</th>
                    <th>Staff ID</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $sql = "SELECT * FROM payment";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    while ($row = $result->fetch_assoc()) {
                        echo "<tr>
                                <td>" . $row["payment_id"] . "</td>
                                <td>" . $row["payment_date"] . "</td>
                                <td>" . $row["amount"] . "</td>
                                <td>" . $row["transaction_details"] . "</td>
                                <td>" . $row["bill_id"] . "</td>
                                <td>" . $row["order_id"] . "</td>
                                <td>" . $row["release_order_id"] . "</td>
                                <td>" . $row["staff_id"] . "</td>
                              </tr>";
                    }
                } else {
                    echo "<tr><td colspan='8'>No payments found</td></tr>";
                }
                ?>
            </tbody>
        </table>
    </div>
</div>

<?php include('../includes/footer.php'); ?>