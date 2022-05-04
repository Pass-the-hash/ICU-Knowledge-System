import Vue from 'vue'
import App from './App.vue'
import router from './router/index'
import vuetify from './plugins/vuetify'
import VueApexCharts from "vue-apexcharts"
import store from './plugins/auth'
// import i18n from "@/plugins/i18n";

Vue.use(VueApexCharts)
Vue.component('apexchart', VueApexCharts)

new Vue({
  el: "#app",
  router,
  vuetify,
  store,
  // i18n,
  render: h => h(App)
}).$mount('#app')
