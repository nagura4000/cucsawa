<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <title>在庫</title>
	    <!-- BootstrapのCSS読み込み -->
	    <link href="css/bootstrap.min.css" rel="stylesheet">
	    <!-- jQuery読み込み -->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	    <!-- BootstrapのJS読み込み -->
	    <script src="js/bootstrap.min.js"></script>
	    <script src="js/jquery.qrcode.min.js"></script>
    </head>
    <body>
		<h3>生産実績</h3>
    	<div class="container">
    		<table class="table table-striped table-bordered table-hover ">
    		    <thead>
			      <tr>
			      	<th>生産実績No</th>
			      	<th>生産計画No</th>
			        <th>製品数</th>
			        <th>社員名</th>
			        <th>製品</th>
			        <th>在庫No</th>
			        <th>倉庫</th>
			        <th>入庫日時</th>
			        <th>出庫日時</th>
			        <th>QRコード</th>
			      </tr>
			    </thead>
			    <tbody>
					
					% for production_info in production_infos:
					<tr>
						<td>{{production_info[0]}}</td>
						<td>{{production_info[1]}}</td>
						<td>{{production_info[2]}}</td>
						<td>{{production_info[3]}}</td>
						<td>{{production_info[4]}}</td>
						% if production_info[5] is not None:
							<td><a href='/stock_detail?row={{production_info[7]}}&col={{production_info[8]}}&depth={{production_info[9]}}'>{{production_info[5]}}</a></td>
							<td>{{production_info[6]}} [行={{production_info[7]}}] [列={{production_info[8]}}] [奥行={{production_info[9]}}]</td>
							<td>{{production_info[10]}}</td>
							<td>{{production_info[11]}}</td>
						% else:
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						% end
						<td><div id="qrcode"></div></td>
						<script>
						$(window).on("load",function(){
						  $('#qrcode').qrcode({width: 64,height: 64,text: "{{production_info[5]}},[{{production_info[7]}},{{production_info[8]}},{{production_info[9]}}]"});
						});
						</script>
					</tr>
					% end
		        </tbody>
			</table>
		</div>
		
		

		
		<h3>在庫登録</h3>
		<div class="container">
		    <form action="/stock" method="POST">
		        <div class="form-group">
		        
	            <label>倉庫名</label>	
	            <select name="id_warehouse_mst" class="form-control">
	            	% for warehouse in warehouses:
	            	<option value="{{warehouse[0]}}">{{warehouse[1]}}</option>
	            	% end
	            </select>	
		        <div class="form-group">
		            <label>列番号</label>
		            <input type="number" name="col" class="form-control">
		        </div>
		        <div class="form-group">
		            <label>行番号</label>
		            <input type="number" name="row" class="form-control">
		        </div>
		        <div class="form-group">
		            <label>奥行番号</label>
		            <input type="number" name="depth" class="form-control">
		        </div>
		        <div class="form-group">
		            <label>入庫日時</label>
		            <input type="datetime-local" name="instock_time" class="form-control">
		        </div> 
		        <input type="hidden" name="id_production_info" value="{{production_info[0]}}">
		        <button type="submit">登録</button>
		        
		    	</div>
		    </form>
		</div>

    </body>
</html>