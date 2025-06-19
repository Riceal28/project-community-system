layui.use(['table', 'form', 'laydate'], function() {
    var table = layui.table,
        form = layui.form,
        laydate = layui.laydate;

    // 日期选择器
    laydate.render({
        elem: '#visitCreateDate',
        type: 'datetime',
        range: true
    });

    // 初始化表格
    table.render({
        elem: '#visitTable',
        url: '/housing/accessVisit/getDataByPage',
        method: 'get',
        page: true,
        limit: 10,
        where: {
            page: 1,
            limit: 10
        },
        cols: [[
            {type: 'numbers', title: 'No.444', width: 60},
            {field: 'userName', title: 'Name', width: 100},
            {field: 'phone', title: 'Phone number', width: 120},
            {title: '健康码', templet: '#visitImageTemp', width: 80},
            {title: '行程码', templet: '#visitImage2Temp', width: 80},
            {field: 'type', title: '是否疑似病例', templet: '#visitTypeTemp', width: 120},
            {field: 'type1', title: '是否隔离', templet: '#visitType1Temp', width: 100},
            {field: 'type2', title: '疫苗接种情况', width: 120},
            {field: 'createDate', title: '填报时间', width: 160},
            {field: 'desc', title: '备注'}
        ]],
        response: {
            statusCode: 0
        },
        parseData: function(res) {
            console.log('返回数据：', res);  // 调试用
            return {
                "code": res.code,
                "msg": res.msg,
                "count": res.count,
                "data": res.data
            };
        }
    });

    // 搜索功能
    $('#searchVisitBtn').click(function() {
        table.reload('visitTable', {
            page: {
                curr: 1
            },
            where: {
                userName: $('input[name="userName"]').val(),
                createDate: $('#visitCreateDate').val()
            }
        });
    });
});