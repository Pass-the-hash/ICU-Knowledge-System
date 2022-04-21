module.exports = {
  devServer: {
    port: 8000,
    /*proxy: {
      'Postman': {
        target: 'https://loclhost:5555',
        changeOrigin: true,
      }
    }*/
  },
  transpileDependencies: ["vuetify"],
};
