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
    return await conn.query(sql, [audit.auditName, audit.status]);
}

async function getAuditInfo(id){
    const conn = await connect();
    const [rows] = await conn.query('call show_livestock_audit(?);', id);    
    
    return rows[0];
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
async function getAuditByName(name){
    const conn = await connect();
    const [rows] = await conn.query('SELECT * FROM audit WHERE name = ?;', name);  
    if (rows.length===0) {
        return false;
    }
    return true;
}

async function addLivestockAudit(id, tag){
    const conn = await connect();
    const [rows] = await conn.query('call add_livestock_audit(?, ?);',[ id, tag ]);    
 
    return rows;
}
async function removeLivestockAudit(id, tag){
    const conn = await connect();
    const [rows] = await conn.query('call remove_livestock_audit(?, ?);',[ id, tag ]);    
    
    return rows;
}
async function removeAudit(id){
    const conn = await connect();
    await conn.query('DELETE FROM audit_livestock where fk_audit_id = ?;', id);    
    const [rows] = await conn.query('DELETE FROM audit WHERE id =?;', id);    
    
    return rows;
}
async function getLivestockDetails(tag){
    const conn = await connect();
    const sql = "SELECT l.tag, l.months_age, l.note, l.color, l.weight, lt.name as 'type', c.stage FROM livestock as l, livestock_type as lt, category as c WHERE l.fk_livestock_type_id = lt.id AND  l.fk_category_id = c.id AND l.tag = ?;";
    const [rows] = await conn.query(sql, tag);
    
    return rows[0];
}
module.exports = {getAudits, addAudit, getAuditInfo, getAuditName, 
                getUnauditedItems, addLivestockAudit, removeLivestockAudit,
                removeAudit, getAuditByName, getLivestockDetails}