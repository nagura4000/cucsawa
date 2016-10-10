<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <title>生産実績</title>
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
			      	<th>生産計画No</th>
			        <th>社員名</th>
			        <th>機械</th>
			        <th>製品</th>
			        <th>生産予定数</th>
			        <th>生産予定年月日</th>
			      </tr>
			    </thead>
			    <tbody>
			    	% for row in rows:
					<tr>
						<td><a href="/production_detail?planningId={{row[0]}}">{{row[0]}}</a></td>
						<td>{{row[1]}}</td>
						<td>{{row[2]}}</td>
						<td>{{row[3]}}</td>
						<td>{{row[4]}}</td>
						<td>{{row[5]}}</td>
					</tr>
		        	% end
		        </tbody>
			</table>
		</div>
		
    </body>
</html>