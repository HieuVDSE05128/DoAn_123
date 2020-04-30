var material = {
    init: function () {
        material.registerFunction();
    },
    registerFunction: function () {
        $('.hildeBtnAjax').off('click').on('click', function (e) {
            e.preventDefault();
            var MaterialId = $(this).data('id')
            $.ajax({
                url: "/FhoHome/HideMaterial",
                data: { MaterialId: MaterialId },
                type: "Post",
                success: function (data) {
                    if (data.status == true) {
                        $('#MaterialHide-' + MaterialId).text('Bỏ ẩn');
                    } else {
                        $('#MaterialHide-' + MaterialId).text('Ẩn đi');
                    }
                },
                error: function (message) {
                    alert(message);
                }
            });
        });

    }
}
material.init();