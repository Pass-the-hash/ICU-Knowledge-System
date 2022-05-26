<template>
<div>
  <v-card
    max-width="475"
    class="mx-auto mb-14"
  >
    <v-img
      src="https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
      height="300px"
      dark
    >
    </v-img>
    <v-list two-line>
      <v-list-item>
        <v-list-item-icon>
          <v-icon color="success">
            mdi-account
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>{{user.name}} {{user.surname}}</v-list-item-title>
          <v-list-item-subtitle>Ονοματεπώνυμο</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>

      <v-divider inset></v-divider>

      <v-list-item>
        <v-list-item-icon>
          <v-icon color="success">
            mdi-feature-search
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>{{user.domain}}</v-list-item-title>
          <v-list-item-subtitle>Ειδικότητα</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-divider inset></v-divider>
      <v-list-item>
        <v-list-item-icon>
          <v-icon  color="success">mdi-cake</v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>{{user.age}}</v-list-item-title>
          <v-list-item-subtitle>Ηλικία</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>

      <v-divider inset></v-divider>

      <v-list-item>
        <v-list-item-icon>
          <v-icon color="success">
            mdi-email
          </v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title>{{user.email}}</v-list-item-title>
          <v-list-item-subtitle>E-mail επικοινωνίας</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-divider inset></v-divider>

      <v-list-item>
        <v-list-item-icon>
          <v-icon color="success">
            mdi-phone
          </v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title>{{ user.phone }}</v-list-item-title>
          <v-list-item-subtitle>Τηλέφωνο</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>

      <v-divider inset></v-divider>

      <v-list-item>
        <v-list-item-icon>
          <v-icon color="success">
            mdi-map-marker
          </v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title>{{ user.address }}</v-list-item-title>
          <v-list-item-subtitle>Διεύθυνση</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
    </v-list>
    <v-card-actions>
      <v-btn
        text
        color="success"
        @click="dialog=true"
      >
        Ενημερωση
      </v-btn>
    </v-card-actions>
  </v-card>
  <v-row class="fill-height">
      <v-dialog
          v-model="dialog"
          persistent
          max-width="600px"
      >
        <v-card>
          <v-card-title>
            <span class="text-h5">User Profile</span>
          </v-card-title>
          <v-card-text>
            <v-form
                lazy-validation
            >
              <v-row>
                <v-col
                    cols="12"
                    sm="6"
                >
                  <v-text-field
                      color="success"
                      text-color="black"
                      v-model="user.name"
                      label="Όνομα"
                  ></v-text-field>
                </v-col>
                <v-col
                    cols="12"
                    sm="6"
                >
                  <v-text-field
                      color="success"
                      text-color="black"
                      label="Επώνυμο"
                      v-model="user.surname"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col
                    cols="12"
                >
                  <v-text-field
                      color="success"
                      text-color="black"
                      v-model="user.age"
                      :rules="[(v) => !!v || 'Πρέπει να είναι θετικός αριθμός', (v) => /^\d+$/.test(v) || 'Πρέπει να είναι θετικός αριθμός']"
                      label="Ηλικία"
                      type="number"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-text-field
                      color="success"
                      text-color="black"
                      v-model="user.email"
                      label="Email"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-text-field
                      color="success"
                      text-color="black"
                      v-model="user.phone"
                      label="Τηλέφωνο"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-text-field
                      color="success"
                      text-color="black"
                      v-model="user.address"
                      label="Διεύθυνση"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="12">
                  <v-text-field
                      color="success"
                      text-color="black"
                      v-model="user.password"
                      label="Νέος κωδικός"
                      type="password"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col
                    cols="12"
                >
                  <v-autocomplete
                      color="success"
                      text-color="black"
                      item-color="success"
                      v-model="user.domain"
                      :items="['Ιατρός', 'Νοσηλευτής', 'Διαχειριστής συστήματος']"
                      label="Ειδικότητα"
                  ></v-autocomplete>
                </v-col>
              </v-row>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
                color="success"
                text
                @click="dialog = false"
            >
              ακυρωση
            </v-btn>
            <v-btn
                color="success"
                text
                @click="update"
            >
              αποθηκευση
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    <v-spacer></v-spacer>
  </v-row>
</div>
</template>

<script>
import axios from "axios";

// const user = localStorage.getItem('user')
export default {
  name: "Workers",
  data() {
    return {
      id: localStorage.getItem('user'),
      user: {
        // domain: []
      },
      dialog: false,
      headers: {
        headers:{
          'Authorization': `Basic ${localStorage.getItem("accessToken")}`
        }
      },
    };
  },
  created() {
    this.get()
  },
  methods: {
    async get() {
      //let user =
      axios
        .get("http://localhost:3000/workers/" + this.id, this.headers)
        .then((response) => (this.user = response.data));
    },
    update(){
      axios
        .patch("http://localhost:3000/workers/" + this.id, this.user, this.headers)
        .then((response) => (
            this.user = response.data
        ));
      this.dialog = false
    },
  },
};
</script>
<style scoped>

</style>