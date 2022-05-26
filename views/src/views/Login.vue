<template>


  <v-card
      max-width="500" class="mx-auto my-14"
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
      <v-divider></v-divider>
      <v-card-text>
        <v-container>
          <v-alert type="error" v-if="loginError">
            {{loginError}}
          </v-alert>
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
  </v-card>
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
      show1: false,
    };
  },
  computed: {
    ...mapState([
      'loginError',
    ])
  },
  methods: {
    ...mapActions([
      'doLogin'
    ]),
    submit() {
      this.doLogin({
        username: this.user.username,
        password: this.user.password
      })
    },
  },
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