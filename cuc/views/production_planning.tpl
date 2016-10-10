<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <title>生産計画</title>
	    <!-- BootstrapのCSS読み込み -->
	    <link href="css/bootstrap.min.css" rel="stylesheet">
	    <!-- jQuery読み込み -->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	    <!-- BootstrapのJS読み込み -->
	    <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
    
		<div class="dropdown">
		  <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
		    社員名
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" role="menu">
	    	% for row in rows:
			<li><a href="#" data-value="{{row[0]}}">{{row[1]}}</a></li>
        	% end
		  </ul>
		  <input type="hidden" name="id_employee" value="">
		</div>

		<script type="text/javascript">
		$(function(){
		  $(".dropdown-menu li a").click(function(){
		    $(this).parents('.dropdown').find('.dropdown-toggle').html($(this).text() + ' <span class="caret"></span>');
		    $(this).parents('.dropdown').find('input[name="id_employee"]').val($(this).attr("data-value"));
		  });
		});
		</script>
		
    </body>
</html>