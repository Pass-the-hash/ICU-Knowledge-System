<template>
  <div>
    <h1>ΧΡΗΣΤΗΣ: {{ user.name }} {{ user.surname }}</h1>
    <v-container class="justify-center">
      <v-card class="justify-center" max-width="344">
        <v-card-text>
          <div><h2>ΣΤΟΙΧΕΙΑ</h2></div>
        </v-card-text>
        <v-expansion-panels focusable>
          <v-expansion-panel>
            <v-expansion-panel-header @click="show = false"
              >Όνομα</v-expansion-panel-header
            >
            <v-expansion-panel-content>
              {{ user.name }}
              <v-btn text color="deep-purple accent-4" @click="show = !show">
                Επεξεργασία
              </v-btn>
              <v-text-field
                v-show="show"
                v-model="name"
                label="Νέο όνομα"
                required
              ></v-text-field>
            </v-expansion-panel-content>
          </v-expansion-panel>
          <v-expansion-panel>
            <v-expansion-panel-header @click="show = false">
              Επίθετο
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              {{ user.surname }}
              <v-btn text color="deep-purple accent-4" @click="show = !show">
                Επεξεργασία
              </v-btn>
              <v-text-field
                v-show="show"
                v-model="surname"
                label="Νέο επίθετο"
                required
              ></v-text-field>
            </v-expansion-panel-content>
          </v-expansion-panel>
          <v-expansion-panel>
            <v-expansion-panel-header @click="show = false">
              Ηλικία
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              {{ user.age }}
              <v-btn text color="deep-purple accent-4" @click="show = !show">
                Επεξεργασία
              </v-btn>
            </v-expansion-panel-content>
          </v-expansion-panel>
          <v-expansion-panel>
            <v-expansion-panel-header @click="show = false">
              Ειδικότητα
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              {{ user.domain }}
              <v-btn text color="deep-purple accent-4" @click="show = !show">
                Επεξεργασία
              </v-btn>
              <v-text-field
                v-show="show"
                v-model="domain"
                label="Νέο επίθετο"
                required
              ></v-text-field>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
        <v-card-actions> </v-card-actions>
      </v-card>
    </v-container>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Workers",
  data() {
    return {
      user: null,
      show: false,
      name: " ",
      surname: null,
      age: null,
      domain: null,
    };
  },
  created() {
    this.get();
  },
  methods: {
    get() {
      axios
        .get("http://localhost:3000/workers/61a2ca99edc9f01119d94645")
        .then((response) => (this.user = response.data));
    },
  },
};
</script>

