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
		
            /*Animation loading web*/
            $(window).on('load', function(event) {
            	$('body').removeClass('preloading');
            	$('.loader').delay(1000).fadeOut('fast');
            });
            /*Animation loading web*/
            /*Opacity web loading*/
            document.addEventListener("DOMContentLoaded" , function(){
            	var hieuung3 = document.querySelector('.s3');
            	vitrihieuung3 = hieuung3.offsetTop - 600;
            	trangthaihieuung3 = 'dilen';
            	window.addEventListener('scroll',function(){
            		if (window.pageYOffset > vitrihieuung3) {
            			if (trangthaihieuung3 == 'dilen') {
            				trangthaihieuung3 = 'dixuong';
            				hieuung3.classList.toggle('chuyenlen');
            			}
            		}
            	})
            	var hieuung2 = document.querySelector('.s2');
            	vitrihieuung2 = hieuung2.offsetTop - 600;
            	trangthaihieuung2 = 'dilen';
            	window.addEventListener('scroll',function(){
            		if (window.pageYOffset > vitrihieuung2) {
            			if (trangthaihieuung2 == 'dilen') {
            				trangthaihieuung2 = 'dixuong';
            				hieuung2.classList.toggle('chuyenlen2');
            			}
            		}
            	})
            	var hieuung1 = document.querySelector('.s1');
            	vitrihieuung1 = hieuung1.offsetTop - 600;
            	trangthaihieuung1 = 'dilen';
            	window.addEventListener('scroll',function(){
            		if (window.pageYOffset > vitrihieuung1) {
            			if (trangthaihieuung1 == 'dilen') {
            				trangthaihieuung1 = 'dixuong';
            				hieuung1.classList.toggle('chuyenlen1');
            			}
            		}
            	})
            	var hieuung0 = document.querySelector('.s0');
            	vitrihieuung0 = hieuung0.offsetTop - 600;
            	trangthaihieuung0 = 'dilen';
            	window.addEventListener('scroll',function(){
            		if (window.pageYOffset > vitrihieuung0) {
            			if (trangthaihieuung0 == 'dilen') {
            				trangthaihieuung0 = 'dixuong';
            				hieuung0.classList.toggle('chuyenlen0');
            			}
            		}
            	})

            } , false)
            /*Opacity web loading*/
