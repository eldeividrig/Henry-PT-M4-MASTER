const { Router } = require('express');
const { Op, Character, Role } = require('../db');
const router = Router();

router.post('/', async (req, res) => {
    const { code, name, hp, mana } = req.body;
    if (!code || !name || !hp || !mana) return res.status(404).send('Falta enviar datos obligatorios');
    try {
        const character = await Character.create(req.body);
        res.status(201).json(character);
    } catch (error) {
        res.status(404).send('Error en alguno de los datos provistos');
    }
    
})

router.get('/',async (req, res) => {
    const { race } = req.query;
    const condition = {};
    const where = {};
    if(race) where.race = race;
    condition.where = where;
    const character = await Character.findAll(condition);
    res.json(character);
})

router.get('/:code',async (req, res) => {
    const { code } = req.params;
    
    const character = await Character.findByPk(code);
    if(!character) return res.status(404).send(`El código ${code} no corresponde a un personaje existente`);
    res.json(character);
})

module.exports = router;