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

module.exports = {getAudits, addAudit}