import Vue from 'vue'
import Router from 'vue-router'
import NotFound from '../components/NotFound'
import Main from '../components/Main'
import Patients from '../components/Patients'
import PatientCreate from '../components/PatientCreate'
import Workers from '../components/Workers'

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
    {
      path: '/analysis',
      name: 'Useful analytics',
      component: NotFound
    },
    {
      path: '*',
      name: 'NotFound',
      component: NotFound
    }
  ]
})
