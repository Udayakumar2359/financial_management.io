</main>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha2/js/bootstrap.min.js"></script>
</body>
<div class="container-fluid" class="foot" style="margin-top: 100px;">
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