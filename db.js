var mysql = require('mysql2/promise');

async function connect(){
    if(global.connection && global.connection.state !== 'disconnected'){
        return global.connection;
    }

    const connection = await mysql.createConnection({
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'Welcome1234',
        database: 'ranch_audit'
    });
    console.log('Conectou no MySQL!');
    global.connection = connection;
    return global.connection;
}

async function getAudits(){
    const conn = await connect();
    const [rows] = await conn.query('SELECT * FROM ranch_audit.audit;');    
    
    return rows;
}

async function addAudit(audit){
    const conn = await connect();
    const sql = "INSERT INTO audit (name, date, status) VALUES (?, CURRENT_DATE(), ?);";
    return await conn.query(sql, [audit.name, audit.status]);
}

async function getAuditInfo(id){
    const conn = await connect();
    const [rows] = await conn.query('call show_livestock_audit(?);', id);    
    
    return rows;
}

async function getUnauditedItems(id){
    const conn = await connect();
    const [rows] = await conn.query('call show_unaudited_items(?);', id);    
    
    return rows;
}

async function getAuditName(id){
    const conn = await connect();
    const [rows] = await conn.query('SELECT name FROM audit WHERE id = ?;', id);    
    
    return rows;
}

async function addItemToAudit(id, tag){
    const conn = await connect();
    const [rows] = await conn.query('call add_livestock_audit(?, ?);',[ id, tag ]);    
    
    return rows;
}
module.exports = {getAudits, addAudit, getAuditInfo, getAuditName, getUnauditedItems, addItemToAudit}