import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import router from "@/router";

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    loggingIn: false,
    loginError: null,
    accessToken: null,
    user: null
  },
  mutations: {
    loginStart: state => state.loggingIn = true,
    loginStop: (state, errorMessage) => {
      state.loggingIn = false;
      state.loginError = errorMessage;
      // state.loginSuccessful = !errorMessage;
    },
    updateAccessToken: (state, accessToken) => {
      state.accessToken = accessToken
    },
    setUser: (state, user) => {
      state.user = user
    },
    LogOut(state){
      localStorage.clear()
      state.user = null
      state.accessToken = null
    }
  },
  getters: {
    isAuthenticated: state => !!state.accessToken,
    isUser: state => !!state.user,
    Error: state => !!state.loginError
  },
  actions: {
    doLogin({ commit }, loginData) {
      commit('loginStart')
      axios.post('http://localhost:3000/auth/login', {
        ...loginData
      })
      .then((response) => {
        localStorage.setItem('accessToken', response.data.token)
        localStorage.setItem('user', response.data.id)
        commit('loginStop', null)
        // commit('keepUser', response.data.id)
        commit('updateAccessToken', response.data.token)
        commit('setUser', response.data.id)
        router.push('/').then()
      })
      // .then(() => this.$router.push('/'))
      .catch(error => {
        if (error.response) {
          if (error.response.status === '401')
            commit('loginStop', 'Λάθος κωδικός')
          else if (error.response.status === '404')
            commit('loginStop', 'Ο χρήστης δεν υπάρχει')
          else {
            commit('loginStop', error.response.data.error)
            commit('updateAccessToken', null)
          }

        } else {
          console.log('Error', error.message)
        }

      })
    },
    fetchAccessToken({ commit }) {
      commit('updateAccessToken', localStorage.getItem('accessToken'));
    }
  }
})

export default store