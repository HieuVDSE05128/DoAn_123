		/* back to top */
		$(document).ready(function() {
			$(window).scroll(function(event) {
				var pos_body = $('html,body').scrollTop();
				if(pos_body>0){
					$('.menu').addClass('co-dinh-menu');
				}
				else {
					$('.menu').removeClass('co-dinh-menu');
				}
				if(pos_body>500){
					$('.back-to-top').addClass('hien-ra');
				}
				else{
					$('.back-to-top').removeClass('hien-ra');
				}
			});
			$('.back-to-top').click(function(event) {
				$('html,body').animate({
					scrollTop: 0},
					1000);
			});
		});
		/* back to top */
		/*Modal create file*/
		$(document).ready(function () {
			var modal = $('.bisu');
			var btn = $('.su');
			var span = $('.close-modal');

			btn.click(function () {
				modal.show();
			});

			span.click(function () {
				modal.hide();
			});

			$(window).on('click', function (e) {
				if ($(e.target).is('.bisu')) {
					modal.hide();
				}
			});
		});
		/*Modal create file*/
		/*Modal change file name*/
		$(document).ready(function () {
			var modal = $('.trang');
			var btn = $('.heo');
			var span = $('.close-modal');

			btn.click(function () {
				modal.show();
			});

			span.click(function () {
				modal.hide();
			});

			$(window).on('click', function (e) {
				if ($(e.target).is('.trang')) {
					modal.hide();
				}
			});
		});
		/*Modal change file name*/
		/*model delete file*/
		var modal = document.getElementById('id01');
		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}
		/*model delete file*/
		/*		grid list view*/
		$('button').on('click',function(e) {
			if($(this).hasClass('list')) {
				$('#container .ul').removeClass('grid').addClass('list');
			}
			else if ($(this).hasClass('grid')) {
				$('#container .ul').removeClass('list').addClass('grid');
			}
		});
		/*		grid list view*/
		/*		filer*/
		filterSelection("all")
		function filterSelection(c) {
			var x, i;
			x = document.getElementsByClassName("filterDiv");
			if (c == "all") c = "";
			for (i = 0; i < x.length; i++) {
				w3RemoveClass(x[i], "show");
				if (x[i].className.indexOf(c) > -1) w3AddClass(x[i], "show");
			}
		}

		function w3AddClass(element, name) {
			var i, arr1, arr2;
			arr1 = element.className.split(" ");
			arr2 = name.split(" ");
			for (i = 0; i < arr2.length; i++) {
				if (arr1.indexOf(arr2[i]) == -1) {element.className += " " + arr2[i];}
			}
		}

		function w3RemoveClass(element, name) {
			var i, arr1, arr2;
			arr1 = element.className.split(" ");
			arr2 = name.split(" ");
			for (i = 0; i < arr2.length; i++) {
				while (arr1.indexOf(arr2[i]) > -1) {
					arr1.splice(arr1.indexOf(arr2[i]), 1);     
				}
			}
			element.className = arr1.join(" ");
		}
		var btnContainer = document.getElementById("myBtnContainer");
		var btns = document.getElementsByClassName("bton");
		for (var i = 0; i < btns.length; i++) {
			btns[i].addEventListener("click", function(){
				var current = document.getElementsByClassName("active");
				current[0].className = current[0].className.replace(" active", "");
				this.className += " active";
			});
		}
		/*		filer*/
