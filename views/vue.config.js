module.exports = {
  devServer: {
    port: 8000,
    proxy: 'http://localhost:3000'
  },
  transpileDependencies: ["vuetify"],
};
