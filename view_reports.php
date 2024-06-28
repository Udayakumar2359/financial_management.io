<?php include('includes/header.php'); ?>
<?php include('includes/db.php'); ?>

<div class="container-fluid">
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
                        <a class="nav-link dropdown-toggle" href="#" id="invoiceDropdown" role="button" data-toggle="dropdown" aria-expanded="false">Invoice</a>
                        <ul class="dropdown-menu" aria-labelledby="invoiceDropdown">
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
                    <li class="nav-item">
                        <a class="nav-link active" href="view_reports.php">View Reports</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>

<div class="container-fluid" style="padding-top: 80px;">
    <div class="container">
        <h2>Reports</h2>
    </div>
    <div class="row">
        <!-- Revenue Report Card -->
        <div class="col-md-4">
            <div class="card mb-3">
                <div class="card-body">
                    <h3 class="card-title">Revenue Report</h3>
                    <?php
                    $sql_revenue = "SELECT SUM(amount) AS total_revenue FROM payment";
                    $result_revenue = $conn->query($sql_revenue);
                    $row_revenue = $result_revenue->fetch_assoc();
                    echo "<p class='card-text'>Total Revenue: " . $row_revenue['total_revenue'] . "</p>";
                    ?>
                    <canvas id="revenueChart" height="200"></canvas>
                </div>
            </div>
        </div>

        <!-- Outstanding Payments Card -->
        <div class="col-md-4">
            <div class="card mb-3">
                <div class="card-body">
                    <h3 class="card-title">Outstanding Payments</h3>
                    <?php
                    $sql_outstanding = "SELECT SUM(total_amount) AS total_outstanding, COUNT(*) AS count_outstanding FROM billing WHERE status = 'Not Paid'";
                    $result_outstanding = $conn->query($sql_outstanding);
                    $row_outstanding = $result_outstanding->fetch_assoc();
                    echo "<p class='card-text'>Total Outstanding Payments: " . $row_outstanding['total_outstanding'] . "</p>";
                    echo "<p class='card-text'>Count of Outstanding Payments: " . $row_outstanding['count_outstanding'] . "</p>";
                    ?>
                    <canvas id="outstandingChart" height="200"></canvas>
                </div>
            </div>
        </div>

        <!-- Profitability Card -->
        <div class="col-md-4">
            <div class="card mb-3">
                <div class="card-body">
                    <h3 class="card-title">Profitability</h3>
                    <?php
                    $sql_profitability = "SELECT 
                                        (SELECT SUM(amount) FROM payment) - 
                                        (SELECT SUM(total_amount) FROM billing WHERE status = 'Not Paid') AS profitability";
                    $result_profitability = $conn->query($sql_profitability);
                    $row_profitability = $result_profitability->fetch_assoc();
                    echo "<p class='card-text'>Profitability: " . $row_profitability['profitability'] . "</p>";
                    ?>
                    <canvas id="profitabilityChart" height="200"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include('includes/footer.php'); ?>

<!-- Chart.js Library -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Data from PHP
    const totalRevenue = <?php echo $row_revenue['total_revenue']; ?>;
    const totalOutstanding = <?php echo $row_outstanding['total_outstanding']; ?>;
    const countOutstanding = <?php echo $row_outstanding['count_outstanding']; ?>;
    const profitability = <?php echo $row_profitability['profitability']; ?>;

    // Revenue Chart
    const ctxRevenue = document.getElementById('revenueChart').getContext('2d');
    const revenueChart = new Chart(ctxRevenue, {
        type: 'bar',
        data: {
            labels: ['Revenue'],
            datasets: [{
                label: 'Total Revenue',
                data: [totalRevenue],
                backgroundColor: ['rgba(75, 192, 192, 0.2)'],
                borderColor: ['rgba(75, 192, 192, 1)'],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Outstanding Payments Chart
    const ctxOutstanding = document.getElementById('outstandingChart').getContext('2d');
    const outstandingChart = new Chart(ctxOutstanding, {
        type: 'bar',
        data: {
            labels: ['Total Outstanding Payments', 'Count of Outstanding Payments'],
            datasets: [{
                label: 'Outstanding Payments',
                data: [totalOutstanding, countOutstanding],
                backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(255, 159, 64, 0.2)'],
                borderColor: ['rgba(255, 99, 132, 1)', 'rgba(255, 159, 64, 1)'],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Profitability Chart
    const ctxProfitability = document.getElementById('profitabilityChart').getContext('2d');
    const profitabilityChart = new Chart(ctxProfitability, {
        type: 'bar',
        data: {
            labels: ['Profitability'],
            datasets: [{
                label: 'Profitability',
                data: [profitability],
                backgroundColor: ['rgba(54, 162, 235, 0.2)'],
                borderColor: ['rgba(54, 162, 235, 1)'],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>