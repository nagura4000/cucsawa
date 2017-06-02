<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>気温</title>
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

    	<div id="stage"></div>
		<script>
var data = [
% for row in reversed(rows):
	{ label: "{{row[3]}}", y: {{row[1]}} },
% end
];

var data2 = [
% for row in reversed(rows):
	{ label: "{{row[3]}}", y: {{row[2]}} },
% end
];
var stage = document.getElementById('stage');
var chart = new CanvasJS.Chart(stage, {
  title: {
    text: "気温"  //グラフタイトル
  },
  theme: "theme4",  //テーマ設定
  data: [{
    type: 'line',		//グラフの種類
    name: "センサー気温",
    legendText: "センサー気温",
    showInLegend: true,
    dataPoints: data	//表示するデータ
  },{
    type: 'line',		//グラフの種類
    name: "外気温",
    legendText: "外気温",
    showInLegend: true,
    dataPoints: data2	//表示するデータ
  }]
});
chart.render();
		</script>
    </body>
</html>
