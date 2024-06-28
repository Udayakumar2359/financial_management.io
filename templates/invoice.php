<?php include('../includes/header.php'); ?>
<?php include('../includes/db.php'); ?>

<div class="row">
    <div class="col-md-12">
        <button class="btn btn-secondary float-right" style="margin-top: 30px;" onclick="history.back()">Back</button>
        <h2 style="padding-top: 30px;">Invoices</h2>

        <table class="table table-bordered" style="margin-top: 80px; border:2px;">
            <thead>
                <tr>
                    <th>Invoice ID</th>
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
                    while ($row = $result->fetch_assoc()) {
                        echo "<tr>
                                <td>" . $row["bill_id"] . "</td>
                                <td>" . $row["date"] . "</td>
                                <td>" . $row["total_days"] . "</td>
                                <td>" . $row["charge_per_day"] . "</td>
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
                    echo "<tr><td colspan='11'>No invoices found</td></tr>";
                }
                ?>
            </tbody>
        </table>
    </div>
</div>

<?php include('../includes/footer.php'); ?>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>