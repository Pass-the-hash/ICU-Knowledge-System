import Vue from 'vue'
import Router from 'vue-router'
// import store from "@/plugins/auth"
import NotFound from '../views/NotFound'
import Main from '../views/Main'
import Patients from '../views/Patients'
import PatientCreate from '../components/PatientCreate'
import Worker from '../views/Worker'
import General from "@/views/General"
import Construction from "@/views/Construction"
import Login from "@/views/Login"

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Index',
      component: Main,
      meta: { requiresAuth: true }
    },
    {
      path: '/patients',
      name: 'View patients',
      component: Patients,
      // props: true,
      meta: { requiresAuth: true }
    },
    {
      path: '/patients/create',
      name: 'Create patient',
      component: PatientCreate,
      meta: { requiresAuth: true }
    },
    {
      path: '/worker',
      name: 'Employees profile page',
      component: Worker,
      meta: { requiresAuth: true }
    },
    /*{
      path: '/admin',
      name: "Administrator's page",
      component: Admin
    },*/
    {
      path: '/analysis/:AMKA',
      name: 'statistics',
      component: General,
      props: true,
      meta: { requiresAuth: true }
    },
    {
      path: '/construct',
      component: Construction,
      name: 'Under construction',
      meta: { requiresAuth: true }
    },
    {
      path: '/login',
      name: "Login",
      component: Login,
      //meta: { guest: true },
    },
    {
      path: '*',
      name: 'NotFound',
      component: NotFound
    }
  ]
})

router.beforeEach((to, from, next) => {
  let isAuthenticated = !!localStorage.getItem('accessToken');
  if (!isAuthenticated && to.matched.some(record => record.meta.requiresAuth)) {
    next('/login')
  } else {
    next()
  }
})

export default router