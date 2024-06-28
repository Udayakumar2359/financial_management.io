<?php include('../includes/header.php'); ?>
<?php include('../includes/db.php'); ?>

<div class="row">
    <div class="col-md-12">
        <h2>Billing</h2>
        <table class="table table-bordered bg-dark">
            <thead>
                <tr>
                    <th>Billing ID</th>
                    <th>Date</th>
                    <th>Total Days</th>
                    <th>Charge Per Day</th>
                    <th>Total Amount</th>
                    <th>Bill Date</th>
                    <th>Due Date</th>
                    <th>Status</th>
                    <th>Seize Order ID</th>
                    <th>Staff ID</th>
                    <th>Custody Charge ID</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $sql = "SELECT * FROM billing";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        echo "<tr>
                                <td>" . $row["billing_id"] . "</td>
                                <td>" . $row["date"] . "</td>
                                <td>" . $row["total_days"] . "</td>
                                <td>" . $row["chahrge_per_day"] . "</td>
                                <td>" . $row["total_amount"] . "</td>
                                <td>" . $row["bill_date"] . "</td>
                                <td>" . $row["due_date"] . "</td>
                                <td>" . $row["status"] . "</td>
                                <td>" . $row["seize_order_id"] . "</td>
                                <td>" . $row["staff_id"] . "</td>
                                <td>" . $row["custody_charge_id"] . "</td>
                              </tr>";
                    }
                } else {
                    echo "<tr><td colspan='11'>No billing records found</td></tr>";
                }
                ?>
            </tbody>
        </table>
    </div>
</div>

<?php include('../includes/footer.php'); ?>
