var material = {
    init: function () {
        material.registerEvents();
    },
    registerEvents: function () {
        //$('.btn btn-success hidenItem').off('click').on('click', function (e) {
        $('.btn-active').off('click').on('click', function (e) {
            e.preventDefault();
            var btn = $(this);
            var id = btn.data('id');
            $.ajax({
                url: "../PRMain/ChangeHiddenStatus",
                data: { id: id },
                dataType: "json",
                type: "POST",
                success: function (response) {
                    if (response.status == true) {
                        btn.text('UnHide');
                        $("#materials" + id).remove();
                    } else {
                        btn.text('Hide');
                        
                        
                    }
                }
            });
        });
    }
}
material.init();

function w3RemoveClass(element, name) {
    var i, arr1, arr2;
    arr1 = element.className.split(" ");
    arr2 = name.split(" ");
    var className = "";
    for (i = 0; i < arr1.length - 1; i++) {
        className = className + arr1[i] + " ";
    }
    element.className = className;
}

function deleteMaterialModalConfirm(materialDeleteId) {
    document.getElementById('MaterialIDForDelete').setAttribute("value", materialDeleteId);
    document.getElementById('id01').style.display = 'block';

}