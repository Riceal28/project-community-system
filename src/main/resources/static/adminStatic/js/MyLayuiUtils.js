//标记，防止表单重复提交
var lock = true;

/**
 * 为按钮绑定单击事件，打开弹窗
 * @param url       跳转的控制器
 * @param title     窗口标题
 * @param width     窗口宽度(例如：200px)
 * @param height    窗口高度(例如：200px)
 */
function toWindow(url, title, width, height) {
    layer.open({
        type: 2,
        title: title,
        shadeClose: true,
        shade: 0.3,
        // maxmin: true, //开启最大化最小化按钮
        area: [width, height],
        content: url,
        // skin: 'layui-layer-lan'
    });
};

/**
 * 为查询按钮绑定单击事件，打开弹窗(适用于头部工具条)
 * @param count     选中的数量
 * @param title     窗口标题
 * @param url       跳转的控制器
 * @param width     窗口宽度
 * @param height    窗口高度
 */
function findInfo(count, title, url, width, height) {
    if (count == 0) {
        layer.open({
            title: 'Error'
            , content: 'Please select a row before operating!'
            // , skin: 'layui-layer-lan'
            , shade: 0.1
            , icon: 5
            , anim: 6
            , closeBtn: 0
        })
    } else if (count > 1) {
        layer.open({
            title: 'Error'
            , content: 'You can only select one row to manipulate!'
            // , skin: 'layui-layer-lan'
            , shade: 0.1
            , icon: 5
            , anim: 6
            , closeBtn: 0
        })
    } else {
        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.3,
            // maxmin: true, //开启最大化最小化按钮
            area: [width, height],
            content: url,        //跳转至控制器处理
            // skin: 'layui-layer-lan'
        });
    }
};

/**
 * 为查询按钮绑定单击事件，打开弹窗(适用于行内工具条)
 * @param title     窗口标题
 * @param url       跳转的控制器
 * @param width     窗口宽度
 * @param height    窗口高度
 */
function findInfoLineTool(title, url, width, height) {
    layer.open({
        type: 2,
        title: title,
        shadeClose: true,
        shade: 0.3,
        // maxmin: true, //开启最大化最小化按钮
        area: [width, height],
        content: url,        //跳转至控制器处理
        // skin: 'layui-layer-lan'

    });
};

/**
 * 获取选中ID
 * 处理传入的所有数据的数组，获取数据中的ID
 * @param dataArray
 * @returns {*}
 */
function getIds(dataArray) {
    var resultIds = -1;
    if (dataArray.length == 1) {           //如果获取的选中行只有一行，直接获取数组第一个的ID
        resultIds = dataArray[0].id;
        return resultIds;
    } else if (dataArray.length == 0) {     //如果选中行为0，返回-1
        return resultIds;
    } else if (dataArray.length > 1) {      //如果选中行大于1行，可能是删除，循环处理选中ID
        $.each(dataArray, function () {
            var data = $(this).get(0);
            resultIds += data.id + ",";
        });
        //如果flag已经不再是-1，就将前面的-1截取掉，同时截掉最后一个逗号
        if (resultIds != -1) {
            resultIds = resultIds.substring(2, resultIds.length - 1);
        }
        return resultIds;
    }
}

/**
 * 获取选中ID(加单引号)
 * 处理传入的所有数据的数组，获取数据中的ID
 * @param dataArray
 * @returns {*}
 */
function getIdsAddSymbol(dataArray) {
    var resultIds = -1;
    if (dataArray.length == 1) {           //如果获取的选中行只有一行，直接获取数组第一个的ID
        resultIds = "'" + dataArray[0].id + "'";
        return resultIds;
    } else if (dataArray.length == 0) {     //如果选中行为0，返回-1
        return resultIds;
    } else if (dataArray.length > 1) {      //如果选中行大于1行，可能是删除，循环处理选中ID
        $.each(dataArray, function () {
            var data = $(this).get(0);
            resultIds += "'" + data.id + "',";
        });
        //如果flag已经不再是-1，就将前面的-1截取掉，同时截掉最后一个逗号
        if (resultIds != -1) {
            resultIds = resultIds.substring(2, resultIds.length - 1);
        }
        return resultIds;
    }
}

/**
 * 删除方法
 * @param count
 * @param dataId
 * @param url
 */
function deleteInfo(count, dataId, url) {
    if (count == 0) {
        layer.open({
            title: 'Error'
            , content: 'Please select a row before operating!'
            // , skin: 'layui-layer-lan'
            , shade: 0.1
            , icon: 5
            , anim: 6
            , closeBtn: 0
        })
    } else {
        if (lock) {
            lock = false;
            layer.confirm('Are you sure you want to delete all selected rows?', {
                btn: ['Yes', 'No'] //按钮
                , shade: 0.1
                , icon: 5
                , anim: 6
                , closeBtn: 0
            }, function () { //确定
                //调用异步删除方法
                $.getJSON(
                    url,
                    function (rollData) {
                        // 207有不可删除的原因, 200成功, 500删除失败
                        if (rollData.code == 207) {
                            layer.confirm(rollData.msg, {
                                btn: ['OK'] //按钮
                                , icon: 7
                            }, function () {
                                layer.closeAll();
                                lock = true;
                            })
                        } else {
                            if (rollData.code == 0) {
                                layer.confirm(rollData.msg, {
                                    btn: ['OK'] //按钮
                                    , icon: 6
                                }, function () {
                                    window.location.reload();
                                    lock = true;
                                })
                            } else {
                                layer.confirm(rollData.msg, {
                                    btn: ['OK'] //按钮
                                    , icon: 5
                                    , anim: 6
                                }, function () {
                                    window.location.reload();
                                    lock = true;
                                })
                            }
                        }
                    }
                )
            }, function () { //取消
                lock = true;
                layer.msg('Cancel', {
                    icon: 6
                    , time: 2000
                });
            })
        }
    }
}

/**
 * 绑定回车事件
 */
$(document).keypress(function (e) {
    //如果当前有类似layer.alert的窗体，点击最上层的确定按钮，并且取消所有焦点
    if ($('.layui-layer-btn0').length > 0) {
        $('.layui-layer-btn0').eq($('.layui-layer-btn0').length - 1)[0].click();
        $("*").blur();
    }
});

/**
 * 导出方法
 * (利用layui的内置导出方法)
 * @param title     表格标题
 * @param data      导出的数据
 * @param type      导出类型(支持：csv和xls两种)
 */
function exportExcelFile(title, data, type) {
    layui.use(['table'], function () {
        var table = layui.table;
        table.exportFile(title, data, type);
    })
}

/**
 * 处理导出时的表头, 将被隐藏的表头筛选
 * 如果表格中有复选框推荐使用 handleTitleDataRemoveCheckbox 方法
 * @param tHead     表头的原生对象(该对象应该是一个数组)
 */
function handleTitleData(tHead) {
    var title = new Array(0);
    // 循环处理表头信息
    for (i = 0; i < tHead.length; i++) {
        // 没有被隐藏
        if (!$(tHead[i]).is(':hidden') && $(tHead[i]).text() != "Operation") {
            // 将没有被隐藏的表头加入标题数组中
            title.push($(tHead[i]).text());
        }
    }
    return title;
}

/**
 * 获取表头的data-field属性值
 * 该方法是为了除去表格中的复选框列
 * @param tHead     表头的原生对象(该对象应该是一个数组)
 */
function handleTitleDataRemoveCheckbox(tHead) {
    var title = new Array(0);
    // 循环处理表头信息
    for (i = 0; i < tHead.length; i++) {
        // 没有被隐藏
        if (!$(tHead[i]).is(':hidden') && $(tHead[i]).attr("data-field") != 0 && $(tHead[i]).text() != "Operation") {
            // 将没有被隐藏的表头加入标题数组中
            title.push($(tHead[i]).text());
        }
    }
    return title;
}

/**
 * 验证是否有数据可以导出
 * @param exportData
 * @returns {boolean}
 */
function verifyExport(exportData) {
    if (!exportData || exportData.length == 0) {
        layer.open({
            title: 'Error'
            , content: 'Sorry... No data found to export!'
            // , skin: 'layui-layer-lan'
            , shade: 0.1
            , icon: 5
            , anim: 6
            , closeBtn: 0
        });
        return false;
    }
    return true;
}

/**
 * 查询本页数据并导出
 * @param title
 * @param allExportData
 * @param queryData
 * @param page
 * @param limit
 */
function findAllExportData(title, url, queryData, load) {
    var resUrl = url + "?" + queryData;
    $.get(
        resUrl,
        function (data) {
            if (data.code == "200") {
                // 执行导出
                exportExcelFile(title, data.data, "xls");
                // 关闭加载层
                layer.close(load);
            } else {
                layer.close(load);
                layer.open({
                    title: 'Error'
                    , content: 'Sorry... No data found to export!'
                    // , skin: 'layui-layer-lan'
                    , shade: 0.1
                    , icon: 5
                    , anim: 6
                    , closeBtn: 0
                });
            }
        }
    )
}

/**
 * 查询全部数据并导出
 * @param title
 * @param pageExportData
 * @param queryData
 */
function findPageExportData(title, url, queryData, page, limit, load) {
    var resUrl = url + "?page=" + page + "&limit=" + limit + "&" + queryData;
    $.get(
        resUrl,
        function (data) {
            if (data.code == "200") {
                // 执行导出
                exportExcelFile(title, data.data, "xls");
                // 关闭加载层
                layer.close(load);
            } else {
                layer.close(load);
                layer.open({
                    title: 'Error'
                    , content: 'Sorry... No data found to export!'
                    // , skin: 'layui-layer-lan'
                    , shade: 0.1
                    , icon: 5
                    , anim: 6
                    , closeBtn: 0
                });
            }
        }
    )
}

/**
 * Ajax请求出错时进行的提示
 */
$(document).ajaxError(function(event,request, settings){
    layer.confirm('Oops! There was a problem with the access!', {
        btn: ['OK']  //按钮
        // , skin: 'layui-layer-lan'
        , icon: 5
        , anim: 6
    }, function (index) {
        layer.close(index);
    });
})

/**
 * 提示窗口
 */
function tips() {
    layer.open({
        title: 'Tip'
        , content: 'If you need to modify, just click on the cell to start modifying!'
        // , skin: 'layui-layer-lan'
        , shade: 0.1
        , icon: 7
        , closeBtn: 0
    });
}

/**
 * 获取项目根目录
 * @returns {string}
 */
function getPath() {
    //获取项目路径
    var curRequestPath = window.document.location.href;
    //获取项目请求路径
    var pathName = window.document.location.pathname;
    var ipAndPort = curRequestPath.indexOf(pathName);
    var localhostPath = curRequestPath.substring(0,ipAndPort);
    var projectName = pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    basePath = localhostPath + projectName;
    return basePath;
}

// -----------------------------------------------------------------------------------------
// -------------------------------------- 正则验证身份证号 Start ------------------------------
// -----------------------------------------------------------------------------------------

/**
 * 验证身份证号
 * @param val
 * @returns {string}
 */
function checkID(val) {
    if(checkCode(val)) {
        if (val && val.length > 0) {
            return "";  // 表示输入合法
        } else {
            return "Please enter the ID number";
        }
    }
    return "The ID card input format is incorrect!";
}

/**
 * 验证校验码
 * @param val
 * @returns {boolean}
 */
function checkCode(val) {
    var p = /^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
    var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
    var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
    var code = val.substring(17);
    if(p.test(val)) {
        var sum = 0;
        for(var i=0;i<17;i++) {
            sum += val[i]*factor[i];
        }
        if(parity[sum % 11] == code.toUpperCase()) {
            return true;
        }
    }
    return false;
}

/**
 * 验证日期是否合法
 * @param val
 * @returns {boolean}
 */
function checkDate(val) {
    var pattern = /^(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)$/;
    if(pattern.test(val)) {
        var year = val.substring(0, 4);
        var month = val.substring(4, 6);
        var date = val.substring(6, 8);
        var date2 = new Date(year+"-"+month+"-"+date);
        if(date2 && date2.getMonth() == (parseInt(month) - 1)) {
            return true;
        }
    }
    return false;
}

/**
 * 验证省份编号是否正确
 * @param val
 * @returns {boolean}
 */
function checkProvince(val) {
    var pattern = /^[1-9][0-9]/;
    var provs = {11:"Beijing",12:"Tianjin",13:"Hebei",14:"Shanxi",15:"Inner Mongolia",21:"Liaoning",22:"Jilin",23:"Heilongjiang",31:"Shanghai",32:"Jiangsu",33:"Zhejiang",34:"Anhui",35:"Fujian",36:"Jiangxi",37:"Shandong",41:"Henan",42:"Hubei",43:"Hunan",44:"Guangdong",45:"Guangxi",46:"Hainan",50:"Chongqing",51:"Sichuan",52:"Guizhou",53:"Yunnan",54:"Tibet",61:"Shaanxi",62:"Gansu",63:"Qinghai",64:"Ningxia",65:"Xinjiang",71:"Taiwan",81:"Hong Kong",82:"Macao"};
    if(pattern.test(val)) {
        if(provs[val]) {
            return true;
        }
    }
    return false;
}
// -----------------------------------------------------------------------------------------
// -------------------------------------- 正则验证身份证号 End --------------------------------
// -----------------------------------------------------------------------------------------



// -----------------------------------------------------------------------------------------
// -------------------------------------- 正则验证手机号码 Start ------------------------------
// -----------------------------------------------------------------------------------------
/**
 * 验证手机号
 * @param phoneNum
 * @returns {string}
 */
function checkPhone(phoneNum) {
    // 手机号正则
    var rePhone = /^.+$/;
    if(!phoneNum) {
        return "Please enter the complete information";
    } else if(!rePhone.test(phoneNum)) {
        return "The phone number format is incorrect!"
    }
}
// -----------------------------------------------------------------------------------------
// -------------------------------------- 正则验证手机号码 End --------------------------------
// -----------------------------------------------------------------------------------------


// -----------------------------------------------------------------------------------------
// -------------------------------------- 正则验证数字 Start ------------------------------
// -----------------------------------------------------------------------------------------
/**
 * 验证是否是正整数
 * @param number
 * @returns {string}
 */
function checkNumber(number) {
    // 手机号正则
    var reNumber = /^[0-9]+$/;
    if(!number) {
        return "Please enter the complete information";
    } else if(!reNumber.test(number)) {
        return "Please enter a correct positive integer!"
    }
}
// -----------------------------------------------------------------------------------------
// -------------------------------------- 正则验证数字 End --------------------------------
// -----------------------------------------------------------------------------------------