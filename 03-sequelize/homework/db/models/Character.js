const { DataTypes } = require('sequelize');
const { get } = require('../../server');

module.exports = sequelize => {
  sequelize.define('Character', {
    code:{
      type: DataTypes.STRING(5),
      primaryKey: true,
      validate: {
        isNotHenry(value) {
          if(value.toLowerCase() === 'henry'){
            throw new Error('Any combinaton of Henry');
          }
        }
      }
    },
    name:{
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
      validate: {
        notIn: [['Henry', 'Soy Henry', 'SoyHenry']]
      }
    },
    age: {
      type: DataTypes.INTEGER,
      get() {
        const rawValue = this.getDataValue('age');
        return rawValue ?  rawValue + ' years old' : null;
      }
    },
    race:{
      type: DataTypes.ENUM('Human', 'Elf', 'Machine', 'Demon', 'Animal', 'Other'),
      defaultValue: 'Other'
    },
    hp: {
      type: DataTypes.FLOAT,
      allowNull: false
    },
    mana: {
      type: DataTypes.FLOAT,
      allowNull: false
    },
    date_added: {
      type: DataTypes.DATEONLY,
      defaultValue: DataTypes.NOW
    }
  },{
    timestamps: false
  })
}

//Adicionalmente queremos quitar los timestamps automáticos de createdAt y updatedAt.