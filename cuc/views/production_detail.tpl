<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>生産実績</title>
	    <!-- BootstrapのCSS読み込み -->
	    <link href="css/bootstrap.min.css" rel="stylesheet">
	    <!-- jQuery読み込み -->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	    <!-- BootstrapのJS読み込み -->
	    <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
    	<h3>生産計画</h3>
    	<div class="table-responsive">
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
					<tr>
						<td>{{production_planning[0]}}</td>
						<td>{{production_planning[1]}}</td>
						<td>{{production_planning[2]}}</td>
						<td>{{production_planning[3]}}</td>
						<td>{{production_planning[4]}}</td>
						<td>{{production_planning[5]}}</td>
		        </tbody>
			</table>
		</div>
		
		<h3>生産実績</h3>
    	<div class="container">
    		<table class="table table-striped table-bordered table-hover ">
    		    <thead>
			      <tr>
			      	<th>生産実績No</th>
			        <th>良品数</th>
			        <th>不良品数</th>
			        <th>開始日時</th>
			        <th>完成日時</th>
			        <th>倉庫</th>
			      </tr>
			    </thead>
			    <tbody>
					
					% for production_info in production_infos:
					<tr>
						<td><a href='/stock?infoId={{production_info[0]}}'>{{production_info[0]}}</a></td>
						<td>{{production_info[1]}}</td>
						<td>{{production_info[2]}}</td>
						<td>{{production_info[3]}}</td>
						<td>{{production_info[4]}}</td>
						
						% if production_info[5] is not None:
							<td>{{production_info[5]}}</td>
						% else:
							<td></td>
						% end
						
					</tr>
					% end
		        </tbody>
			</table>
		</div>
		
		<div class="container">
		    <form action="/production_detail" method="POST">
		        <div class="form-group">
		            <label>良品数</label>
		            <input type="number" name="success_number" class="form-control">
		        </div>
		        <div class="form-group">
		            <label>不良品数</label>
		            <input type="number" name="failure_number" class="form-control">
		        </div>
		        <div class="form-group">
		            <label>作業開始時刻</label>
		            <input type="datetime-local" name="start_date" class="form-control">
		        </div>		        
		        <div class="form-group">
		            <label>作業完了時刻</label>
		            <input type="datetime-local" name="end_date" class="form-control">
		        </div>
		        <input type="hidden" name="id_production_planning" value="{{production_planning[0]}}">
		        <button type="submit">登録</button>
		    </form>
		</div>

    </body>
</html>