<?php include('includes/header.php'); ?>
<style>
    body {
        background-color: rgb(230, 230, 250);
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        height: 100vh;
    }

    .card {
        margin-top: 10%;
        width: 30%;
        float: left;
        margin: 5px;
    }
    .footer{
        margin-top: auto;
    }
</style>
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
                        <a class="nav-link active" aria-current="page" href="index.php">Home</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="paymentDropdown" role="button" data-toggle="dropdown" aria-expanded="false">Invoice</a>
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
                    <li class="nav-item">
                        <a class="nav-link" href="view_reports.php">View Reports</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>


<div class="starter-template text-center" style="padding-top: 80px; margin-bottom:80px;">
    <h1 style="color:black;">Welcome to Financial Management System</h1>
    <p class="lead"></p>
</div>
<div class="card">
    <div class="card-header">
        Invoices
    </div>
    <div class="card-body">
        <h5 class="card-title">Invoice Management</h5>
        <p class="card-text">Create and manage invoices for services rendered or products sold.</p>
        <a href="templates/invoice.php" class="btn btn-primary">Go to Invoice</a>
    </div>
</div>
<div class="card">
    <div class="card-header">
        Payments
    </div>
    <div class="card-body">
        <h5 class="card-title">Payment Processing</h5>
        <p class="card-text">Handle the receipt and recording of payments from customers.</p>
        <a href="templates/payment.php" class="btn btn-primary">Go to payments</a>
    </div>
</div>
<div class="card">
    <div class="card-header">
        Reports
    </div>
    <div class="card-body">
        <h5 class="card-title">Financial Reports</h5>
        <p class="card-text">Generate reports to analyze revenue, outstanding payments, and profitability.</p>
        <a href="view_reports.php" class="btn btn-primary">Go to Reports</a>
    </div>
</div>
</main>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha2/js/bootstrap.min.js"></script>
</body>
<div class="container-fluid" class="foot" style="margin-top: 605px;">
    <footer class="footer mt-auto py-3 bg-light">
        <div class="container text-center">
            <span class="text-muted">
                <span id="currentYear"></span> &copy; Financial Management System
            </span>
        </div>
    </footer>
</div>
<script>
    document.getElementById('currentYear').innerText = new Date().getFullYear();
</script>

</html>