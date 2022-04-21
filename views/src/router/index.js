import Vue from 'vue'
import Router from 'vue-router'
import NotFound from '../views/NotFound'
import Main from '../views/Main'
import Patients from '../views/Patients'
import PatientCreate from '../components/PatientCreate'
import Workers from '../views/Workers'
import General from "@/views/General";
import Construction from "@/views/Construction";
/*import Statistics from "@/views/Statistics";
import Add from '@/components/Add'*/

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Index',
      component: Main
    },
    {
      path: '/patients',
      name: 'View patients',
      component: Patients,
      props: true,
    },
    {
      path: '/patients/create',
      name: 'Create patient',
      component: PatientCreate
    },
    {
      path: '/workers',
      name: 'Employees profile page',
      component: Workers
    },
    /*{
      path: '/analysis',
      name: 'Προβολή στοιχείων διασωληνωμένων ασθενών',
      component: General
    },*/
    {
      path: '/analysis/:AMKA',
      name: 'statistics',
      component: General,
      props: true
    },
    {
      path: '/construct',
      component: Construction,
      name: 'Under construction'
    },
    {
      path: '*',
      name: 'NotFound',
      component: NotFound
    }
  ]
})
