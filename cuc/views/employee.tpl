<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <title>社員一覧</title>
	    <!-- BootstrapのCSS読み込み -->
	    <link href="css/bootstrap.min.css" rel="stylesheet">
	    <!-- jQuery読み込み -->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	    <!-- BootstrapのJS読み込み -->
	    <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
    	<div class="container">
    		<table class="table table-striped table-bordered table-hover ">
    		    <thead>
			      <tr>
			        <th>名前</th>
			        <th>生年月日</th>
			        <th>入社年月日</th>
			      </tr>
			    </thead>
			    <tbody>
			    	% for row in rows:
					<tr>
						<td>{{row[1]}}</td>
						<td>{{row[2]}}</td>
						<td>{{row[3]}}</td>
					</tr>
		        	% end
		        </tbody>
			</table>
		</div>
    </body>
</html>