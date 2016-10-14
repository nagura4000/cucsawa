<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>生産実績</title>
	    <!-- BootstrapのCSS読み込み -->
	    <link href="css/bootstrap.min.css" rel="stylesheet">
	    <link href="css/bootstrap-responsive.min.css" rel="stylesheet">
	    <!-- jQuery読み込み -->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	    <!-- BootstrapのJS読み込み -->
	    <script src="js/bootstrap.min.js"></script>
	    <script src="js/canvasjs.min.js"></script>
    </head>
    <body>
    	<h3>生産計画</h3>
    	<div class="table-responsive">
    		<table class="table table-striped table-bordered table-hover ">
    		    <thead>
			      <tr>
			      	<th class="col-xs-3 col-ms-3 col-md-4 col-lg-4"><p>生産計画No</p></th>
			        <th class="col-xs-3 col-ms-3 col-md-4 col-lg-4"><p>社員名</p></th>
			        <th class="col-xs-3 col-ms-3 col-md-4 col-lg-4"><p>機械</p></th>
			        <th class="col-xs-3 col-ms-3 col-md-4 col-lg-4"><p>製品</p></th>
			        <th class="col-xs-3 col-ms-3 col-md-4 col-lg-4"><p>生産予定数</p></th>
			        <th class="col-xs-3 col-ms-3 col-md-4 col-lg-4"><p>生産実績数</p></th>
			        <th class="col-xs-3 col-ms-3 col-md-4 col-lg-4"><p>生産予定年月日</p></th>
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
						<td>{{row[6]}}</td>
						<td>{{row[5]}}</td>
					</tr>
		        	% end
		        </tbody>
			</table>
		</div>
		
		<div id="stage"></div>
		<script>
var data = [

% for row in reversed(rows):
	% p_rate = row[6] / row[4] * 100
	{ label: "{{row[1]}} {{p_rate}}%", y: {{p_rate}} },
% end
];

var stage = document.getElementById('stage');
var chart = new CanvasJS.Chart(stage, {
  title: {
    text: "進捗率"  //グラフタイトル
  },
  theme: "theme4",  //テーマ設定
  data: [{
    //type: 'column',  //グラフの種類
    type: 'bar',
    dataPoints: data  //表示するデータ
  }]
});
chart.render();
		</script>
		
    </body>
</html>