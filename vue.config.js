module.exports = {
  devServer: {
    port: 8484,
    proxy: {
      '/api': {
        target: 'http://localhost:8182',
        changeOrigin: true,
      },
    },
  },
};
