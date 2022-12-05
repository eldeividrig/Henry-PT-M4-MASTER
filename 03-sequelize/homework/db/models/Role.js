const { DataTypes } = require('sequelize');

module.exports = sequelize => {
  sequelize.define('Role', {
    name: {
      type: DataTypes.STRING,
      unique: true,
      allowNull: false
    },
    description: {
      type:DataTypes.STRING
    }
  })
}


// Role
// name*: string (Dene ser único)
// description: string
// Las propiedades marcadas con asterístico son obligatorias