<template>
  <v-card
    max-width="375"
    class="mx-auto"
  >
    <v-img
      src="@/assets/images/john-doe.webp"
      height="300px"
      dark
    >
      <v-row class="fill-height">
        <v-card-title>
          <v-btn
            dark
            icon
          >
            <v-icon>mdi-chevron-left</v-icon>
          </v-btn>

          <v-spacer></v-spacer>
          <v-dialog
              v-model="dialog"
              persistent
              max-width="600px"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                  dark
                  icon
                  class="mr-4"
                  v-bind="attrs"
                  v-on="on"
              >
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
            </template>
<!--            <template v-slot:activator="{ on, attrs }">
              <v-btn
                  color="primary"
                  dark
                  v-bind="attrs"
                  v-on="on"
              >
                Open Dialog
              </v-btn>
            </template>-->
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
                        md="4"
                    >
                      <v-text-field
                          v-model="user.name"
                          label="Όνομα"
                      ></v-text-field>
                    </v-col>
                    <v-col
                        cols="12"
                        sm="6"
                        md="4"
                    >
                      <v-text-field
                          label="Επώνυμο"
                          v-model="user.surname"
                      ></v-text-field>
<!--                      <v-text-field
                          label="Legal middle name"
                          hint="example of helper text only on focus"
                      ></v-text-field>-->
                    </v-col>
                    <v-col
                        cols="12"
                        sm="6"
                        md="4"
                    >
                      <v-text-field
                          v-model="user.age"
                          :rules="[(v) => !!v || 'Πρέπει να είναι θετικός αριθμός', (v) => /^\d+$/.test(v) || 'Πρέπει να είναι θετικός αριθμός']"
                          label="Ηλικία"
                          type="number"
                      ></v-text-field>
                    </v-col>
                    <v-col cols="12">
                      <v-text-field
                          v-model="user.email"
                          label="Email"
                      ></v-text-field>
                      <v-text-field
                          v-model="user.phone"
                          label="Τηλέφωνο"
                      ></v-text-field>
                      <v-text-field
                          v-model="user.address"
                          label="Διεύθυνση"
                      ></v-text-field>
                      <v-text-field
                          v-model="user.password"
                          label="Νέος κωδικός"
                          type="password"
                      ></v-text-field>
                    </v-col>
                    <v-col
                        cols="12"
                        sm="6"
                    >

                    </v-col>
                    <v-col
                        cols="12"
                        sm="6"
                    >
                      <v-autocomplete
                          v-model="user.domain"
                          :items="['Ιατρός', 'Νοσηλευτής', 'Διαχειριστής συστήματος']"
                          label="Ειδικότητα"
                      ></v-autocomplete>
                    </v-col>
                  </v-row>
                </v-form>
<!--                <small>*indicates required field</small>-->
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                    color="blue darken-1"
                    text
                    @click="dialog = false"
                >
                  ακυρωση
                </v-btn>
                <v-btn
                    color="blue darken-1"
                    text
                    @click="update"
                >
                  αποθηκευση
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <v-btn
            dark
            icon
          >
            <v-icon>mdi-dots-vertical</v-icon>
          </v-btn>
        </v-card-title>

        <v-spacer></v-spacer>

<!--        <v-card-title class="white&#45;&#45;text pl-12 pt-12">
          <div class="text-h4 pl-12 pt-12">
            {{user.name}} {{user.surname}}
          </div>
        </v-card-title>-->
      </v-row>
    </v-img>

    <v-list two-line>
      <v-list-item>
<!--        <v-list-item-action></v-list-item-action>-->
        <v-list-item-icon>
          <v-icon color="indigo">
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
          <v-icon color="indigo">
            mdi-feature-search
          </v-icon>
        </v-list-item-icon>

<!--        <v-list-item-action></v-list-item-action>-->
        <v-list-item-content>
          <v-list-item-title>{{user.domain}}</v-list-item-title>
          <v-list-item-subtitle>Ειδικότητα</v-list-item-subtitle>
        </v-list-item-content>


      </v-list-item>

      <v-divider inset></v-divider>

      <v-list-item>
<!--        <v-list-item-action></v-list-item-action>-->
        <v-list-item-icon>
          <v-icon>mdi-cake</v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>{{user.age}}</v-list-item-title>
          <v-list-item-subtitle>Ηλικία</v-list-item-subtitle>
        </v-list-item-content>

<!--        <v-list-item-icon>
          <v-icon>mdi-message-text</v-icon>
        </v-list-item-icon>-->
      </v-list-item>

      <v-divider inset></v-divider>

      <v-list-item>
        <v-list-item-icon>
          <v-icon color="indigo">
            mdi-email
          </v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title>{{user.email}}</v-list-item-title>
          <v-list-item-subtitle>E-mail επικοινωνίας</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>

<!--      <v-list-item>
        <v-list-item-action></v-list-item-action>

        <v-list-item-content>
          <v-list-item-title>ali_connors@example.com</v-list-item-title>
          <v-list-item-subtitle>Work</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>-->
      <v-divider inset></v-divider>

      <v-list-item>
        <v-list-item-icon>
          <v-icon color="indigo">
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
          <v-icon color="indigo">
            mdi-map-marker
          </v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title>{{ user.address }}</v-list-item-title>
          <v-list-item-subtitle>Διεύθυνση</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
    </v-list>
    <v-row justify="center">
  </v-row>
  </v-card>
</template>

<script>
import axios from "axios";

const user = localStorage.getItem('user')
export default {
  name: "Workers",
  data() {
    return {
      user: {
        // domain: []
      },
      dialog: false,
      headers: {},
      token: null
    };
  },
  created() {
    this.getUserDetails()
    this.get()
  },
  methods: {
    async get() {
      //let user =
      axios
        .get("http://localhost:3000/workers/" + user, this.headers)
        .then((response) => (this.user = response.data));
    },
    update(){
      axios
        .patch("http://localhost:3000/workers/" + user, this.user, this.headers)
        .then((response) => (
            this.user = response.data,
            this.get()
        ));
      // this.get()
      this.dialog = false
    },
    getUserDetails() {
      // get token from localstorage
      this.token = localStorage.getItem("accessToken");
      this.headers = {
        headers:{
          'Authorization': `Basic ${this.token}`
        }
      }
    }
  },
};
</script>
<style scoped>

</style>