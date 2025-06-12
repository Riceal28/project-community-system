$(function(){
	layui.use(['layer'], function() {
		var layer = layui.layer;

		//登录输入框效果
		$('.form_text_ipt input').focus(function(){
			$(this).parent().css({
				'box-shadow':'0 0 3px #bbb',
			});
		});
		$('.form_text_ipt input').blur(function(){
			$(this).parent().css({
				'box-shadow':'none',
			});
			//$(this).parent().next().hide();
		});

		// 登录按钮
		$("#loginBtn").click(function() {
			// 非空验证
			var userName = $("input[name='userName']").val();
			var password = $("input[name='password']").val();
			if(!password || !userName) {
				layer.confirm("Please fill in the complete information！", {
					btn: ['OK'] //按钮
					, icon: 5
					, anim: 6
					, title: 'error message'
				}, function (index) {
					layer.close(index)
				})
				return;
			}
			// 执行登录
			var jsonObj = {
				"userName" : userName,
				"password" : password
			}
			$.ajax({
				url: "webLogin",
				type: 'POST',
				async: false,
				contentType : 'application/json;charset=utf-8', //设置请求头信息
				data: JSON.stringify(jsonObj),
				success: function(res) {
					if (res.code == "0") {
						layer.confirm(res.msg, {
							btn: ['OK']  //按钮
							, icon: 6
						}, function () {
							window.parent.location.reload();    //刷新父页面
						});
					} else {
						layer.confirm(res.msg, {
							btn: ['OK']  //按钮
							, icon: 5
							, anim: 6
						}, function (index) {
							layer.close(index);
						});
					}
				},
				error: function(res) {
					layer.confirm('Oops! There was a problem with the access!', {
						btn: ['OK']  //按钮
						, icon: 5
						, anim: 6
					}, function (index) {
						layer.close(index);
					});
				}
			})
		})
	})
});
