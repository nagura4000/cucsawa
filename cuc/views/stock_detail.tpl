<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>在庫詳細</title>
	    <!-- BootstrapのCSS読み込み -->
	    <link href="css/bootstrap.min.css" rel="stylesheet">
	    <!-- jQuery読み込み -->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	    <!-- BootstrapのJS読み込み -->
	    <script src="js/bootstrap.min.js"></script>
	    <!-- 3D表示 -->
	    <script src="js/three.min.js"></script>
    </head>
    <body>
	
	<div id="stage"></div>
	<script src="three.min.js"></script>
	<script>
	(function() {
		'use strict';
		
		var scene;
		var box;
		var camera;
		var renderer;
		var width = 500;
		var height = 300;
		
		scene = new THREE.Scene();
		
		var target_row = {{row}} - 1;
		var target_col = {{col}} - 1;
		var target_depth = {{depth}} - 1;
		
		for (var i = 0; i < 4; i++) {
			for (var y = 0; y < 3; y++) {
				for (var z = 0; z < 3; z++) {
		
					var material; 
					
					if ( i == target_col && y == target_row && z == target_depth) {
						material = new THREE.MeshLambertMaterial({color: 0xff0000})
					} else {
						material = new THREE.MeshLambertMaterial({color: 0xF0F8FF, transparent: true, opacity: 0.2})
					}
					
					box = new THREE.Mesh(
						new THREE.BoxGeometry(50, 50, 50),
						material
					);		
					
					box.position.set(i * 50, y * 50, z * -50);
					scene.add(box);
				}
			}
		}
		
		var directionalLight = new THREE.DirectionalLight( 0xffffff );
		directionalLight.position.set( 0, 0.7, 0.7 );
		scene.add( directionalLight );
		
		camera = new THREE.PerspectiveCamera(45, width / height, 1, 1000);
		camera.position.set(220, 200, 250);
		camera.lookAt(scene.position);
		
		renderer = new THREE.WebGLRenderer({ antialias: true });
		renderer.setSize(width, height);
		renderer.setClearColor(0xefefef);
		renderer.setPixelRatio(window.devicePixelRatio);
		document.getElementById('stage').appendChild(renderer.domElement);

		renderer.render(scene, camera);
		
	})();
	</script>
 
    </body>
</html>