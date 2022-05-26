<template>
    <v-alert class="py-12" type="error" v-if="!information">
      Δεν έχουν καταχωρηθεί οι κατάλληλες πληροφορίες για τον
      συγκεκριμένο ασθενή !
    </v-alert>
  <v-card v-else>
    <v-toolbar flat >
      <v-toolbar-title>Στατιστικά στοιχεία {{patient.name}} {{patient.surname}}</v-toolbar-title>
      <v-spacer></v-spacer>
      <template v-slot:extension>
        <v-tabs fixed-tabs v-model="tabs" color="success">
          <v-tabs-slider></v-tabs-slider>
          <v-tab href="#statistics" class="success--text">
            <v-icon left> mdi-account-details </v-icon>
            Προβολή στατιστικών
          </v-tab>
          <v-tab href="#add" class="success--text">
            <v-icon left> mdi-account-plus </v-icon>
            Προσθήκη πληροφοριών
          </v-tab>
          <v-tab href="#predictions" class="success--text">
            <v-icon left> mdi-access-point </v-icon>
            Προβλέψεις
          </v-tab>
        </v-tabs>
      </template>
    </v-toolbar>

    <v-tabs-items v-model="tabs">
    <v-tab-item value="add">
        <v-card flat>
          <v-card-text>
            <Add :headers="headers"></Add>
          </v-card-text>
        </v-card>
      </v-tab-item>
      <v-tab-item value="statistics">
        <v-card flat>
          <v-card-text>
            <Statistics
              :patient="patient"
              :information="information"
            ></Statistics>
          </v-card-text>
        </v-card>
      </v-tab-item>
      <v-tab-item value="predictions">
        <v-card flat>
          <v-card-text>
            <Predictions
              :patient="patient"
              :headers="headers"
            ></Predictions>
          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </v-card>

</template>

<script>
import axios from "axios";
import Statistics from "@/components/Statistics";
import Add from "@/components/Add";
import Predictions from "@/components/Predictions";

export default {
  name: "General",
  data: () => ({
    tabs: null,
    patient: null,
    information: null,
    headers: {
      headers: {
        Authorization: `Basic ${localStorage.getItem("accessToken")}`,
      },
    },
  }),
  components: {
    Predictions,
    Add,
    Statistics,
  },
  methods: {
    get() {
      axios
        .get(
          "http://localhost:3000/analysis/" + this.$route.params.AMKA,
          this.headers
        )
        .then((response) => {
          this.information = response.data;
          console.log(this.information);
        });

      axios
        .get(
          "http://localhost:3000/patients/" + this.$route.params.AMKA,
          this.headers
        )
        .then((response) => (this.patient = response.data));
    },
  },
  mounted() {
    this.get();
  },
};
</script>

<style scoped>
h1,
h2 {
  color: azure;
}

</style>
