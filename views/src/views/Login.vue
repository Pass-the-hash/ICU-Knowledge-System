<template>
<v-container
    class="align-content-space-around"
>
  <v-card
      class="d-flex justify-space-around mb-6"
  >
  <v-form
      ref="form"
      lazy-validation
      @submit.prevent="submit"
  >

      <v-toolbar flat color="white success--text ">
        <v-icon color="success">mdi-lock</v-icon>
        <v-toolbar-title class="font-weight-light">
          Είσοδος στην πλατφόρμα
        </v-toolbar-title>
      </v-toolbar>
      <v-card-text>
        <v-container>
          <v-row>
            <v-col cols="12">
              <v-text-field
                  v-model="user.username"
                  color="success"
                  text-color="black"
                  label="Όνομα χρήστη"
                  outlined
              ></v-text-field>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="12">
              <v-text-field
                  v-model="user.password"
                  label="Κωδικός"
                  :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                  :type="show1 ? 'text' : 'password'"
                  color="success"
                  text-color="black"
                  outlined
                  @click:append="show1 = !show1"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
      <v-card-actions class="justify-center">
        <button type="submit"> Υποβολή </button>
      </v-card-actions>

  </v-form>
    <v-alert type="error" v-if="showError">
      {{msg}}
    </v-alert>
  </v-card>
  </v-container>
</template>

<script>
// import axios from "axios"
import { mapState, mapActions } from "vuex"

export default {
  name: "Login",
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: "",
      },
      showError: false,
      show1: false,
      msg: "",
    };
  },
  computed: {
    ...mapState([
      'loggingIn',
      'loginError',
      'accessToken'
    ])
  },
  methods: {
    //...mapActions(["LogIn"]),
    ...mapActions([
      'doLogin'
    ]),
    async submit() {
      this.doLogin({
        username: this.user.username,
        password: this.user.password
      })
      /*axios
          .post("http://localhost:3000/auth/login", this.user)
          .then((response) => localStorage.setItem("user", response.data.token))
          .then(() => this.$router.push('/'))*/

    },
  },
  watch: {
    error: (() => {
      if (this.$store.getters('Error')) {
        this.showError = true
        this.msg = this.$store.state.loginError
      } else this.showError = false
    })
  }
};
</script>

<style scoped>
* {
  box-sizing: border-box;
}
label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}
button[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  cursor: pointer;
  border-radius:30px;
}
button[type=submit]:hover {
  background-color: #45a049;
}
input {
  margin: 5px;
  box-shadow:0 0 15px 4px rgba(0,0,0,0.06);
  padding:10px;
  border-radius:30px;
  color: #45a049;
}

</style>