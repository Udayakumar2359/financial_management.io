<?php include('../includes/header.php'); ?>
<?php include('../includes/db.php'); ?>

<div class="row">
    <div class="col-md-12">
        <h2>Reports</h2>
        
        <!-- Revenue Report -->
        <h3>Revenue Report</h3>
        <?php
        $sql_revenue = "SELECT SUM(amount) AS total_revenue FROM payment";
        $result_revenue = $conn->query($sql_revenue);
        $row_revenue = $result_revenue->fetch_assoc();
        echo "<p>Total Revenue: " . $row_revenue['total_revenue'] . "</p>";
        ?>
        
        <!-- Outstanding Payments -->
        <h3>Outstanding Payments</h3>
        <?php
        $sql_outstanding = "SELECT SUM(total_amount) AS total_outstanding FROM billing WHERE status = 'Not Paid'";
        $result_outstanding = $conn->query($sql_outstanding);
        $row_outstanding = $result_outstanding->fetch_assoc();
        echo "<p>Total Outstanding Payments: " . $row_outstanding['total_outstanding'] . "</p>";
        ?>
        
        <!-- Profitability -->
        <h3>Profitability</h3>
        <?php
        $sql_profitability = "SELECT 
                                (SELECT SUM(amount) FROM payment) - 
                                (SELECT SUM(total_amount) FROM billing WHERE status = 'Not Paid') AS profitability";
        $result_profitability = $conn->query($sql_profitability);
        $row_profitability = $result_profitability->fetch_assoc();
        echo "<p>Profitability: " . $row_profitability['profitability'] . "</p>";
        ?>
    </div>
</div>

<?php include('../includes/footer.php'); ?>
