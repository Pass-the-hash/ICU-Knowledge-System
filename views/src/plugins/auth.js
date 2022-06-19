import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import router from "@/router";

Vue.use(Vuex)

const token = localStorage.getItem('accessToken');
const user = localStorage.getItem('user');

const initialState = token
  ? { loggedIn: true , user:user,loginError:null }
  : { loggedIn: false , user: null,loginError:null };

const store = new Vuex.Store({
  namespaced: true,
  state: initialState,
  mutations: {
    loginSuccess(state, id) {
      state.loggedIn = true;
      state.user = id;
      state.loginError=null
    },
    loginFailure(state) {
      state.loggedIn = false;
      state.loginError = "Invalid username or password !"
      state.user = null;
      console.log(this.state)
    },
    LogOut(state){
      localStorage.clear()
      state.loggedIn= false
      state.user = null
    },
  },
  getters: {
    isAuthenticated: (state) => state.loggedIn,
  },

  actions: {
    doLogin({ commit }, loginData) {
      axios.post('http://localhost:3000/auth/login', {
        ...loginData
      })
      .then((response) => {
        localStorage.setItem('accessToken', response.data.token)
        localStorage.setItem('user', response.data.id)
        commit('loginSuccess', response.data.id);
        router.push('/').then()
      })
      .catch(() => {
          commit('loginFailure');
          console.log(this.state.loggedIn)
      })
    },
    fetchAccessToken({ commit }) {
      commit('updateAccessToken', localStorage.getItem('accessToken'));
    }
  }
})

export default store