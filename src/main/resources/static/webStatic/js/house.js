// 初始数据
const properties = [
    { location: "北京市 朝阳区", area: "120㎡", type: "三室两厅", owner: "张三", phone: "13800001111" },
    { location: "上海市 浦东新区", area: "85㎡", type: "两室一厅", owner: "李四", phone: "13900002222" },
    { location: "广州市 天河区", area: "95㎡", type: "三室一厅", owner: "王五", phone: "13700003333" },
    { location: "深圳市 南山区", area: "110㎡", type: "四室两厅", owner: "赵六", phone: "13600004444" },
    { location: "杭州市 西湖区", area: "100㎡", type: "三室两厅", owner: "钱七", phone: "13500005555" }
];
let houseMessage = document.getElementById("houseMessage")
houseMessage.addEventListener('keydown', function(event) {
    if (event.key === 'Enter') {
        renderTable()
    }
});
// 渲染表格
function renderTable() {
    getHouse()
    const tbody = document.getElementById("tableBody");
    tbody.innerHTML = ""; // 清空旧内容
    data.forEach(item => {
        const row = document.createElement("tr");
        row.innerHTML = `
        <td>${item.location}</td>
        <td>${item.area}</td>
        <td>${item.type}</td>
        <td>${item.owner}</td>
        <td>${item.phone}</td>
      `;
        tbody.appendChild(row);
    });
}
function getHouse(){
    let url = "localhost:2281/houses/getRentalHouse"
    if(houseMessage.value.trim() !== ""){
        url += `?message=${houseMessage.value.trim()}`
    }
    axios.post(url)
        .then(response => {
            const data = response.data;
            console.log('房源数据:', data);
            // TODO: 渲染表格到页面
            // renderTable(data);
        })
        .catch(error => {
            console.error('请求出错:', error);
        });
}
// 初始化表格
renderTable();

// 过滤表格
function filterTable() {
    const keyword = document.getElementById("searchInput").value.toLowerCase();
    const filtered = properties.filter(item =>
        item.location.toLowerCase().includes(keyword) ||
        item.area.toLowerCase().includes(keyword) ||
        item.type.toLowerCase().includes(keyword) ||
        item.owner.toLowerCase().includes(keyword) ||
        item.phone.toLowerCase().includes(keyword)
    );
    renderTable(filtered);
}