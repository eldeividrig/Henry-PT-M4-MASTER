const { Router } = require('express');
const { where } = require('sequelize');
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
    const { race, age } = req.query;
    const condition = {};
    const where = {};
    if(race) where.race = race;
    if(age) where.age = age;
    condition.where = where;
    const character = await Character.findAll(condition);
    res.json(character);
})

router.get('/young', async (req, res) => {

    const characters = await Character.findAll({
        where : {
            age: {[Op.lt]: 25}
        }
    });
    res.json(characters);
})

router.get('/roles/:code',async (req, res) => {
    const { code } = req.params;    
    const character = await Character.findByPk(code, {
        include: Role
    });
    res.json(character);
})

router.get('/:code',async (req, res) => {
    const { code } = req.params;
    
    const character = await Character.findByPk(code);
    if(!character) return res.status(404).send(`El código ${code} no corresponde a un personaje existente`);
    res.json(character);
})

router.put('/addAbilities', async (req, res) => {
    const { codeCharacter, abilities } = req.body;
    const character = await Character.findByPk(codeCharacter);
    const promises = abilities.map(a => character.createAbility(a))
    await Promise.all(promises);    
    res.json('Ok');
})

router.put('/:attribute', async (req, res) => {
    const { attribute } = req.params;
    const { value } = req.query;
    await Character.update({
        [attribute] : value}, {
            where: {[attribute]: null}
        });
    res.send('Personajes actualizados');
})



module.exports = router;